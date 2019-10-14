class TerminationsBySuperintendent {

    static generateDatasets(superintendents) {
        var result = [];
        
        this.data.forEach(function(item, index) {
            if (item.selected) {
            var dataRecommended = TerminationsBySuperintendent.generateDataset(false, true, superintendents, item.id, index, item.num_cases_termination_recommended)
            var dataDecided = TerminationsBySuperintendent.generateDataset(false, false, superintendents, item.id, index, item.num_cases_termination_decided);
            result.push(dataRecommended, dataDecided);
            }
        });
    
        return result;
    }

    static generateDataset(isAverage, isRecommended, superintendents, suId, colorIndex, data) {
        let label = this.generateDatasetLabel(isAverage, isRecommended, superintendents, suId);
        let color = this.getDatasetColor(isAverage, colorIndex);
        let pointBackgroundColor = this.getPointBackgroundColor(color, data);
    
        var dataset = {
            label: label,
            borderColor: color["borderColor"],
            data: data,
            pointBackgroundColor: pointBackgroundColor
        }
    
        if (isRecommended) {
            dataset.backgroundColor = color["backgroundColor"];
            dataset.fill = "+1";
        }
        else {  //is decided
            dataset.fill = false;
            dataset.borderDash = [2.5, 5];
        }
    
        return dataset;
    }

    static generateDatasetLabel(isAverage, isRecommended, superintendents, suId) {
        let label = "";
        if (isAverage) {
            label = (isRecommended) ? "average # cases where superintendent recommended termination" :
                                    "average # cases resulting in termination";
        }
        else {
            let lastName = superintendents.find(su => {return su.id == suId}).last_name;
            label = (isRecommended) ? "# cases where " + lastName + " recommended termination" :
                                    "# of cases resulting in termination under " + lastName + "'s tenure";
        }

        return label;
    }

    static getDatasetColor(isAverage, colorIndex){
        let color = [];
        if (isAverage) {
            color = this.colors.find(c => c["forDataset"] == "average");
        }
        else {
            color = this.colors[colorIndex];
        }

        return color;
    }

    static getPointBackgroundColor(color, data) {
        let pointBackgroundColor = [];
        for (i = 0; i < data.length - 1; i++) {
            pointBackgroundColor.push(color["borderColor"]);
        }

        return pointBackgroundColor;
    }

    static toggleSuperintendentDataVisibility(suElement, superintendents) {
        const id = $(suElement).attr("superintendent-id");
    
        //toggle selected class
        const isSelected = !suElement.classList.contains("deselected");
        if (isSelected) { $(suElement).addClass("deselected"); }
        else { $(suElement).removeClass("deselected"); }
    
        //toggle selected attribute in dataset
        let i = this.data.findIndex(obj => obj.id == id);
        this.data[i].selected = !(this.data[i].selected);
    
        let datasets = this.generateDatasets(superintendents);

        //add average datasets if option checked
        let displayAverages = document.getElementById("display-averages").checked;
        if (displayAverages) {
            datasets = datasets.concat(this.generateAverageDataSets());
        }
        this.chart.data.datasets = datasets;
    
        this.updateYearsOfTenureLabels(displayAverages);
        this.chart.update();
    }

    static generateAverageDataSets() {
        //get averages of non-displayed superintendents
        let maxNumYears = this.getMaxNumYearsForUnselectedSuperintendents();
        let avgRecommended = [], avgDecided = [];
    
        for (var i = 0; i < maxNumYears; i++) {
            let currAverages = this.getAvgUnselectedForCurrYear(i);
            console.log(currAverages['avgRecommended']);
            avgRecommended.push(currAverages['avgRecommended']);
            avgDecided.push(currAverages['avgDecided']);
        }
    
        //add data to dataset
        var dataRecommended = this.generateDataset(true, true, null, 0, 0, avgRecommended);
        var dataDecided = this.generateDataset(true, false, null, 0, 0, avgDecided);
        return [dataRecommended, dataDecided];
    }

    //helper for generateAverageDataSets function
    static getAvgUnselectedForCurrYear(yearIndex) {
        let currYearRecommended = [], currYearDecided = [];

        this.data.forEach(function(item) {
            if (!item.selected && yearIndex < item.num_cases_termination_recommended.length) {
                currYearRecommended.push(item.num_cases_termination_recommended[yearIndex]);
                currYearDecided.push(item.num_cases_termination_decided[yearIndex]);
            }
        });

        let currAvgRecommended = Math.round(currYearRecommended.reduce((a, b) => a + b) / currYearRecommended.length);
        let currAvgDecided = Math.round(currYearDecided.reduce((a, b) => a + b) / currYearDecided.length);
        return {'avgRecommended': currAvgRecommended, 'avgDecided': currAvgDecided};
    }

    static displayAverageData() {
        let avgDatasets = this.generateAverageDataSets();
        this.chart.data.datasets = this.chart.data.datasets.concat(avgDatasets);    
    
        //update x-axis labels
        this.updateYearsOfTenureLabels(true);
    
        this.chart.update();
    }

    static hideAverageData() {
        //if averages are displayed, they will be last 2 datasets - check if last 2 datasets are averages
        if (this.chart.data.datasets[this.chart.data.datasets.length - 1].label.includes("average")) {
            this.chart.data.datasets.splice(-2, 2); //remove last 2 data elements
            this.updateYearsOfTenureLabels(false);
            this.chart.update();
        }
    }

    static updateYearsOfTenureLabels(includeAverages) {
        var labels;
        let maxNumYears = (includeAverages) ? this.getMaxNumYearsForAllSuperintendents() :
                                                this.getMaxNumYearsForSelectedSuperintendents();
        
        //rebuild labels array if not same number of years as before
        if (maxNumYears != this.chart.data.labels.length) {
            labels = Array.from({length: maxNumYears}, (value, key) => {
                let year = key + 1;
                return "Year " + year.toString();
            });
            this.chart.data.labels = labels;
        }
    }

    static getMaxNumYearsForSelectedSuperintendents() {
        return this.getMaxNumYears("selected");
    }

    static getMaxNumYearsForUnselectedSuperintendents() {
        return this.getMaxNumYears("unselected");
    }

    static getMaxNumYearsForAllSuperintendents() {
        return this.getMaxNumYears(null);
    }

    //count longest span of years that a superintendent was in tenure for.
    //for the "filterBy" param, pass "selected" to only check for selected supers, "unselected" for only
    //unselected supers, and null if you are checking across all superintendents
    static getMaxNumYears(filterBy) {
        let maxNumYears = 0;
        let countSelected = (filterBy == "selected");
    
        this.data.forEach(function (obj) {
            //count number of data points in the num_cases_termination_decided array to determine how many years su is in office
            if ((!filterBy || obj.selected == countSelected) && 
                maxNumYears < obj.num_cases_termination_decided.length) {
                maxNumYears = obj.num_cases_termination_decided.length;
            }
        });
        
        return maxNumYears;
    }

}

TerminationsBySuperintendent.colors = [
    {"borderColor": "rgb(160, 15, 18)", "backgroundColor": "rgb(160, 15, 18, 0.2)"}, //red
    {"borderColor": "rgb(0, 114, 173)", "backgroundColor": "rgb(0, 114, 173, 0.2)"}, //blue 
    {"borderColor": "rgb(53, 111, 36)", "backgroundColor": "rgb(53, 111, 36, 0.2)"}, //green
    {"borderColor": "rgb(154, 143, 18)", "backgroundColor": "rgb(154, 143, 18, 0.2)"},
    {"borderColor": "rgb(181, 88, 4)", "backgroundColor": "rgb(181, 88, 4, 0.2)"},
    {"borderColor": "rgb(29, 167, 153)", "backgroundColor": "rgb(29, 167, 153, 0.2)"},
    {"borderColor": "rgb(109, 45, 149)", "backgroundColor": "rgb(109, 45, 149, 0.2)"},
    {"forDataset": "average", "borderColor": "rgb(128, 128, 128)", backgroundColor: "rgb(128, 128, 128, 0.2)"} //grey
];

function setupTerminationsBySuperintendent(superintendents, data) {
    $(function () {
        //initialize chart and data
        TerminationsBySuperintendent.data = data["datasets"];
    
        datasets = TerminationsBySuperintendent.generateDatasets(superintendents);
        if (document.getElementById("display-averages").checked) {
        datasets = datasets.concat(TerminationsBySuperintendent.generateAverageDataSets());
        }
    
        var context = document.getElementById('terminations-by-superintendent').getContext('2d');
        TerminationsBySuperintendent.chart = new Chart(context, {
            type: 'line', 
            data: {
                labels: data["labels"],
                datasets: datasets
            },
            options: {
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Number of Cases'
                }
                }],
                xAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Year of Tenure'
                }
                }]
            }     
            }
        });              
    }); 

    
    //register on click event for superintendent images
    $(".superintendent-thumb").on("click", function() {
        TerminationsBySuperintendent.toggleSuperintendentDataVisibility(this, superintendents);
    });
    
    //register on click for averages checkbox
    $("#display-averages").on("click", function(){
        if (this.checked) {
        TerminationsBySuperintendent.displayAverageData();
        }
        else {
        TerminationsBySuperintendent.hideAverageData();
        }
    });
}



  
  
  
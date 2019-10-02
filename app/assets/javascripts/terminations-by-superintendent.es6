/*-----------------------------------------------+
 | Visualization: Terminations by superintendent |
 | Plugin: ChartJS                               |
 +-----------------------------------------------*/

    class TerminationsBySuperintendent {

        static generateDatasets(superintendents) {
            var result = [];
            
            window.terminationsBySuperintendentData.forEach(function(item, index) {
                if (item.selected) {
                var dataRecommended = TerminationsBySuperintendent.generateDataset(false, true, superintendents, item.id, index, item.num_cases_termination_recommended)
                var dataDecided = TerminationsBySuperintendent.generateDataset(false, false, superintendents, item.id, index, item.num_cases_termination_decided);
                result.push(dataRecommended, dataDecided);
                }
            });
        
            return result;
        }
    
        static generateDataset(isAverage, isRecommended, superintendents, suId, colorIndex, data) {
        let label = "", color = [];
        if (isAverage) {
            label = (isRecommended) ? "average # cases where superintendent recommended termination" :
                                    "average # cases resulting in termination";
            color = this.colors.find(c => c["forDataset"] == "average");
        }
        else {
            let lastName = superintendents.find(su => {return su.id == suId}).last_name;
            label = (isRecommended) ? "# cases where " + lastName + " recommended termination" :
                                    "# of cases resulting in termination under " + lastName + "'s tenure";
            color = this.colors[colorIndex];
        }

        let pointBackgroundColor = [];
        for (i = 0; i < data.length - 1; i++) {
            pointBackgroundColor.push(color["borderColor"]);
        }
    
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
    
        static toggleSuperintendentDataVisibility(suElement, superintendents) {
        const id = $(suElement).attr("superintendent-id");
    
        //toggle selected class
        const isSelected = !suElement.classList.contains("deselected");
        if (isSelected) { $(suElement).addClass("deselected"); }
        else { $(suElement).removeClass("deselected"); }
    
        //toggle selected attribute in dataset
        let chart = window.terminationsBySuperintendentChart, data = window.terminationsBySuperintendentData; //readability
        let i = data.findIndex(obj => obj.id == id);
        data[i].selected = !(data[i].selected);
    
        let datasets = this.generateDatasets(superintendents);
    
        //add average datasets if option checked
        let displayAverages = document.getElementById("display-averages").checked;
        if (displayAverages) {
            datasets = datasets.concat(TerminationsBySuperintendent.generateAverageDataSets());
        }
        chart.data.datasets = datasets;
    
        this.updateYearsOfTenureLabels(data, chart, displayAverages);
        chart.update();
        }
    
        static generateAverageDataSets() {
        //get averages of non-displayed superintendents
        let data = window.terminationsBySuperintendentData;
        let maxNumYears = this.getMaxNumYearsForUnselectedSuperintendents(data);
        let avgRecommended = [], avgDecided = [], currSetRecommended = [], currSetDecided = [];
    
        for (var i = 0; i < maxNumYears; i++) {
            currSetDecided.length = 0;
            currSetRecommended.length = 0;
            data.forEach(function(item) {
            if (!item.selected && i < item.num_cases_termination_recommended.length) {
                currSetRecommended.push(item.num_cases_termination_recommended[i]);
                currSetDecided.push(item.num_cases_termination_decided[i]);
            }
            });
    
            let currAvgRecommended = Math.round(currSetRecommended.reduce((a, b) => a + b) / currSetRecommended.length);
            let currAvgDecided = Math.round(currSetDecided.reduce((a, b) => a + b) / currSetDecided.length);
            avgRecommended.push(currAvgRecommended);
            avgDecided.push(currAvgDecided);
        }
    
        //add data to dataset
        var dataRecommended = this.generateDataset(true, true, null, 0, 0, avgRecommended);
        var dataDecided = this.generateDataset(true, false, null, 0, 0, avgDecided);
        return [dataRecommended, dataDecided];
        }
    
        static displayAverageData() {
        let avgDatasets = this.generateAverageDataSets();
        window.terminationsBySuperintendentChart.data.datasets =
            window.terminationsBySuperintendentChart.data.datasets.concat(avgDatasets);    
    
        //update x-axis labels
        this.updateYearsOfTenureLabels(window.terminationsBySuperintendentData, window.terminationsBySuperintendentChart, true);
    
        window.terminationsBySuperintendentChart.update();
        }
    
        static hideAverageData() {
        let chart = window.terminationsBySuperintendentChart;
        
        //if averages are displayed, they will be last 2 datasets - check if last 2 datasets are averages
        if (chart.data.datasets[chart.data.datasets.length - 1].label.includes("average")) {
            chart.data.datasets.splice(-2, 2); //remove last 2 data elements
            this.updateYearsOfTenureLabels(window.terminationsBySuperintendentData, chart, false);
            chart.update();
        }
        }
    
        static updateYearsOfTenureLabels(data, chart, includeAverages) {
        var labels;
        let maxNumYears = (includeAverages) ? this.getMaxNumYearsForAllSuperintendents(data) :
                                                this.getMaxNumYearsForSelectedSuperintendents(data);
        
        //rebuild labels array if not same number of years as before
        if (maxNumYears != chart.data.labels.length) {
            labels = Array.from({length: maxNumYears}, (value, key) => {
            let year = key + 1;
            return "Year " + year.toString();
            });
            chart.data.labels = labels;
        }
        }
    
        static getMaxNumYearsForSelectedSuperintendents(data) {
        return this.getMaxNumYears(data, "selected");
        }
    
        static getMaxNumYearsForUnselectedSuperintendents(data) {
        return this.getMaxNumYears(data, "unselected");
        }
    
        static getMaxNumYearsForAllSuperintendents(data) {
        return this.getMaxNumYears(data, null);
        }
    
        //count longest span of years that a superintendent was in tenure for.
        //for the "filterBy" param, pass "selected" to only check for selected supers, "unselected" for only
        //unselected supers, and null if you are checking across all superintendents
        static getMaxNumYears(data, filterBy) {
        let maxNumYears = 0;
        let countSelected = (filterBy == "selected");
    
        data.forEach(function (obj) {
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
            window.terminationsBySuperintendentData = data["datasets"];
        
            datasets = TerminationsBySuperintendent.generateDatasets(superintendents);
            if (document.getElementById("display-averages").checked) {
            datasets = datasets.concat(TerminationsBySuperintendent.generateAverageDataSets());
            }
        
            var context = document.getElementById('terminations-by-superintendent').getContext('2d');
            window.terminationsBySuperintendentChart = new Chart(context, {
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



  
  
  
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
        let rgb = {};
        if (isAverage) {
            rgb = this.colors.find(c => c["forDataset"] == "average");
        }
        else {
            rgb = this.colors[colorIndex];
        }

        return {"borderColor": this.generateRGBValue(rgb, "lineBorder"),
                "backgroundColor": this.generateRGBValue(rgb, "lineBackground")};
    }

    static generateRGBValue(rgb, getColorFor) {
        let opacity = 1;
        switch(getColorFor) {
            case "lineBackground":
                opacity = 0.2;
                break;
            case "thumbBorder":
                opacity = 0.8;
                break;
            default:
                break;
        }

        return `rgba(${rgb["red"]}, ${rgb["green"]}, ${rgb["blue"]}, ${opacity})`;
    }

    static getPointBackgroundColor(color, data) {
        let pointBackgroundColor = [];
        for (i = 0; i < data.length - 1; i++) {
            pointBackgroundColor.push(color["borderColor"]);
        }

        return pointBackgroundColor;
    }

    static generateLegend() {
        let legendList = document.createElement("ul");
        legendList.id = "legend-list";

        this.chart.data.datasets.forEach(function(dataset, index) {
            let legendItem = document.createElement("li");
            let legendText = document.createTextNode(dataset.label);
            legendItem.appendChild(TerminationsBySuperintendent.generateLegendSVG(dataset));
            legendItem.appendChild(legendText);
            legendList.appendChild(legendItem);

            if (index % 2) {
                legendList.appendChild(document.createElement("br"));
            }
        });

        document.getElementById("terminations-by-superintendent-legend").appendChild(legendList);
    }

    static updateLegend() {
        document.getElementById("terminations-by-superintendent-legend").innerHTML = "";
        this.generateLegend();
    }

    static generateLegendSVG(dataset) {
        let isDashed = (typeof dataset.borderDash == 'undefined');

        let svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svg.setAttribute('height', '16');
        svg.setAttribute('width', '35');

        let path = document.createElementNS("http://www.w3.org/2000/svg", "path");
        path.setAttribute("d", "M 7 11.5 l 15 0");
        path.setAttribute("stroke", dataset.borderColor);
        path.setAttribute("stroke-width", 2.5);
        path.setAttribute("fill", "none");
        if (isDashed) path.setAttribute("stroke-dasharray", "3 3");

        let g = document.createElementNS("http://www.w3.org/2000/svg", "g");
        g.setAttribute("stroke", dataset.borderColor);
        g.setAttribute("stroke-width", 3);
        g.setAttribute("fill", dataset.borderColor);

        let startPoint = document.createElementNS("http://www.w3.org/2000/svg", "circle");
        startPoint.setAttribute("cx", 3);
        startPoint.setAttribute("cy", 11.5);
        startPoint.setAttribute("r", 1.5);

        let endPoint = document.createElementNS("http://www.w3.org/2000/svg", "circle");
        endPoint.setAttribute("cx", 26);
        endPoint.setAttribute("cy", 11.5);
        endPoint.setAttribute("r", 1.5);

        g.appendChild(startPoint);
        g.appendChild(endPoint);

        svg.appendChild(path);
        svg.appendChild(g);

        return svg;
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
        this.updateChart(displayAverages);
    }

    static generateAverageDataSets() {
        //get averages of non-displayed superintendents
        let maxNumYears = this.getMaxNumYearsForUnselectedSuperintendents();
        let avgRecommended = [], avgDecided = [];
    
        for (var i = 0; i < maxNumYears; i++) {
            let currAverages = this.getAvgUnselectedForCurrYear(i);
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
        this.updateChart();
    }

    static hideAverageData() {
        //if averages are displayed, they will be last 2 datasets - check if last 2 datasets are averages
        if (this.chart.data.datasets[this.chart.data.datasets.length - 1].label.includes("average")) {
            this.chart.data.datasets.splice(-2, 2); //remove last 2 data elements
            this.updateChart();
        }
    }
    
    static updateChartIncludeAverages() {
        this.updateChart(true);
    }

    static updateChart(includeAverages = false) {
        this.updateYearsOfTenureLabels(includeAverages);   //update x-axis labels
        this.updateLegend(this.chart);
        this.chart.update();
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
    {"red": 160, "green": 15, "blue": 18},  //red
    {"red": 0, "green": 114, "blue": 173},  //blue
    {"red": 53, "green": 111, "blue": 36},  //green
    {"red": 154, "green": 143, "blue": 18},
    {"red": 181, "green": 88, "blue": 4},
    {"red": 29, "green": 167, "blue": 153},
    {"red": 109, "green": 45, "blue": 149},
    {"forDataset": "average", "red": 128, "green": 128, "blue": 128}    //grey
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
                },
                legend: {
                    display: false
                }
            }
        });  

        TerminationsBySuperintendent.generateLegend();          
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



  
  
  
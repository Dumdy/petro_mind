import Chart from 'chart.js/auto';



const DownTimeHours = {
    mounted() {
        this.drawChart();
    },

    updated() {
        this.drawChart();
    },

    drawChart() {
        const ctx = this.el.getContext('2d');

        const labels = JSON.parse(this.el.dataset.labels);
        const values = JSON.parse(this.el.dataset.values);


        if (this.chart) {
            this.chart.destroy();
        }

        this.chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Down Time (Hrs)',
                    data: values,
                    backgroundColor: 'rgba(252, 28, 8, 0.5)',
                    borderColor: 'rgb(236, 241, 238)',
                    borderWidth: 1,
                    barThickness: 30
                }]
            },
            options: {
                responsive: true,
                aspectRatio: 2,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0
                        }
                    }
                }
            }
        });
    }
};

export default DownTimeHours;





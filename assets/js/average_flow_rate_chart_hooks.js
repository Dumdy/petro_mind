import Chart from 'chart.js/auto';

const AverageFlowRate = {
    mounted() {
        const ctx = this.el.getContext('2d');

        const labels = JSON.parse(this.el.dataset.labels);
        const values = JSON.parse(this.el.dataset.values);

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Average Flow Rate(m3/day)',
                    data: values,
                    backgroundColor: 'rgba(235, 142, 54, 0.5)',
                    borderColor: 'rgb(235, 172, 54)',
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

export default AverageFlowRate;

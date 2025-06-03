import Chart from 'chart.js/auto';

const DownTimeHours = {
    mounted() {
        const ctx = this.el.getContext('2d');

        const labels = JSON.parse(this.el.dataset.labels);
        const values = JSON.parse(this.el.dataset.values);

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Down Time Hours(Hrs)',
                    data: values,
                    backgroundColor: 'rgb(241, 15, 15)',
                    borderColor: 'rgb(235, 75, 54)',
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

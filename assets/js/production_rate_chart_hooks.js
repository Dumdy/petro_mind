import Chart from 'chart.js/auto';

const ProductionRate = {
  mounted() {
    const ctx = this.el.getContext('2d');

    const labels = JSON.parse(this.el.dataset.labels);
    const values = JSON.parse(this.el.dataset.values);

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Production Rate(bbl/day)',
          data: values,
          backgroundColor: 'rgba(54, 235, 99, 0.5)',
          borderColor: 'rgb(54, 235, 108)',
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

export default ProductionRate;

import Chart from 'chart.js/auto';



const ProductionRate = {
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
          label: 'Production Rate (bbl/day)',
          data: values,
          backgroundColor: 'rgba(54, 235, 99, 0.97)',
          borderColor: 'rgb(249, 252, 250)',
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





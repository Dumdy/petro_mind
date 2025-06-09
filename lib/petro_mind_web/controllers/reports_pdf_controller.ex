# lib/petro_mind_web/controllers/report_pdf_controller.ex
defmodule PetroMindWeb.ReportsPDFController do
  use PetroMindWeb, :controller

  alias PetroMind.Dashboard

  def init(opts) do
    opts
  end

  def download_pdf(conn, %{"id" => id}) do
    report = Dashboard.get_report!(id)

    html =
      Phoenix.View.render_to_string(
        PetroMindWeb.ReportHTML,
        "pdf.html",
        %{report: report}
      )

    #   # Save HTML to a temp file
    temp_html_path = Path.join(System.tmp_dir!(), "report_#{id}.html")
    File.write!(temp_html_path, html)

    #   # Define PDF output path
    output_pdf_path = Path.join(System.tmp_dir!(), "report_#{id}.pdf")

    # Generate PDF using ChromicPDF
    ChromicPDF.print_to_pdfa({:file, temp_html_path}, output: output_pdf_path)

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header("content-disposition", ~s[inline; filename="report_#{id}.pdf"])
    |> send_file(200, output_pdf_path)
  end
end

defmodule DocraptorxSample.PageController do
  use DocraptorxSample.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"document" => document}) do
    options = %{
      document_type: "pdf",
      document_url: document["url"],
      name: "sample.pdf",
      async: document["async"] == "true",
      callback_url: DocraptorxSample.Router.Helpers.url(conn) <> "/callback",
      test: true
    }
    IO.inspect(options)
    response = Docraptorx.create!(options)
    if options.async do
      conn
      |> assign(:status_id, response["status_id"])
      |> render("wait.html")
    else
      conn
      |> put_resp_content_type("application/pdf")
      |> send_resp(200, response)
    end
  end

  def callback(conn, %{"download_id" => status_id, "download_url" => url}) do
    DocraptorxSample.Endpoint.broadcast!("room:" <> status_id, "completed", %{url: url})
    send_resp(conn, :ok, "")
  end
end

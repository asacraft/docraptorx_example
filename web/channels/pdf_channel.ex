defmodule DocraptorxSample.PDFChannel do
  use Phoenix.Channel

  def join(_, _, socket) do
    {:ok, socket}
  end

  def handle_in("status", %{"status_id" => status_id}, socket) do
    case Docraptorx.status!(status_id) do
      %{"status" => "completed", "download_url" => url} ->
        push(socket, "completed", %{url: url})
      %{"status" => "failed"} ->
        push(socket, "failed", %{})
      _ ->
        spawn(fn ->
          :timer.sleep(:timer.seconds(5))
          handle_in("status", %{"status_id" => status_id}, socket)
        end)
    end
    {:noreply, socket}
  end
end

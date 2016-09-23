defmodule DocraptorxSample.PageControllerTest do
  use DocraptorxSample.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Docraptorx Example Application"
  end
end

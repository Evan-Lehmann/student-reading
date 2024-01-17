defmodule AppWeb.PageController do
  use AppWeb, :controller
  import AppWeb.CustomComponents
  alias App.Accounts

  def home(conn, _params) do
    current_user = conn.assigns[:current_user]
    if current_user == nil do
      render(conn, :home, layout: false)
    else
      if current_user.type == "teacher" do
        students = Accounts.list_students_in_class(current_user.username)
        conn
        |> assign(:students, students)
        |> render(:home, layout: false)
      else
        render(conn, :home, layout: false)
      end
    end

  end

end

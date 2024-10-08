defmodule AppWeb.PageController do
  use AppWeb, :controller
  alias App.Accounts
  alias App.Quiz

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
        current_user = conn.assigns[:current_user]
        if current_user.class != nil do
          students = Accounts.list_students_in_class(current_user.class)
          conn
          |> assign(:students, students)
          |> render(:home, layout: false)
        else
          conn
          #|> assign(:code_form, code_form)
          #|> assign(:class_form, class_form)
          #|> assign(:display, "none")
          #|> assign(:class, nil)
          |> render(:home, layout: false)
        end
      end
    end

  end

end

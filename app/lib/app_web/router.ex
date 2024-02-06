defmodule AppWeb.Router do
  use AppWeb, :router

  import AppWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppWeb do
    pipe_through :browser
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", AppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{AppWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", AppWeb do
    pipe_through [:browser, :require_student_not_in_class]

    live_session :require_student_not_in_class,
      on_mount: [{AppWeb.UserAuth, :require_student_not_in_class}] do
      live "/join_class", JoinClass
    end
  end

  scope "/", AppWeb do
    pipe_through [:browser, :require_teacher_access]

    live_session :require_teacher_access,
      on_mount: [{AppWeb.UserAuth, :require_teacher_access}] do
      live "/student/:name", StudentPage
    end
  end

  scope "/", AppWeb do
    pipe_through [:browser, :require_teacher]

    live_session :require_teacher,
      on_mount: [{AppWeb.UserAuth, :require_teacher}] do
      live "/settings", SettingsLive
    end
  end

  scope "/", AppWeb do
    pipe_through [:browser, :require_teacher_or_student_in_class_or_logged_out]

    get "/", PageController, :home
  end

  scope "/", AppWeb do
    pipe_through [:browser, :require_teacher_or_student_in_class]

    live_session :require_teacher_or_student_in_class,
      on_mount: [{AppWeb.UserAuth, :require_teacher_or_student_in_class}] do
      live "/class_index", ClassIndexLive
      live "/shop", ShopLive
      live "/shop/new", NewItem
    end
  end

  scope "/", AppWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end

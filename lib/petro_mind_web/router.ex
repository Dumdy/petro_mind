defmodule PetroMindWeb.Router do
  use PetroMindWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PetroMindWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PetroMindWeb do
    pipe_through :browser

    live "/metrics", MetricLive.Index, :index
    live "/metrics/new", MetricLive.Index, :new
    live "/metrics/:id/edit", MetricLive.Index, :edit
    live "/metrics/:id", MetricLive.Show, :show
    live "/metrics/:id/show/edit", MetricLive.Show, :edit

    live "/reports", ReportLive.Index, :index
    live "/reports/new", ReportLive.Index, :new
    live "/reports/:id/edit", ReportLive.Index, :edit

    live "/reports/:id", ReportLive.Show, :show
    live "/reports/:id/show/edit", ReportLive.Show, :edit

    live "/chats", ChatLive.Index, :index
    live "/chats/new", ChatLive.Index, :new
    live "/chats/:id/edit", ChatLive.Index, :edit

    live "/chats/:id", ChatLive.Show, :show
    live "/chats/:id/show/edit", ChatLive.Show, :edit
    get "/reports/downloads/pdf", ReportsPDFController, :download_pdf
  end

  # Other scopes may use custom stacks.
  # scope "/api", PetroMindWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:petro_mind, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PetroMindWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

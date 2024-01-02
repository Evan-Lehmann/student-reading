defmodule AppWeb.PageHTML do
  use AppWeb, :html
  import AppWeb.CustomComponents
  alias App.Accounts

  embed_templates "page_html/*"
end

defmodule AppWeb.PageHTML do
  use AppWeb, :html
  import AppWeb.CustomComponents


  embed_templates "page_html/*"
end

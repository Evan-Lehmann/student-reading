defmodule AppWeb.Layouts do
  use AppWeb, :html
  import AppWeb.CustomComponents
  alias App.Accounts

  embed_templates "layouts/*"
end

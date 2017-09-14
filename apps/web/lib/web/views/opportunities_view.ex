defmodule Web.OpportunitiesView do
  use Web, :view
  import Scrivener.HTML

  alias Web.Endpoint

  # rather than dynamically creating the gettext key, this function
  # has static gettext keys so that the `mix gettext.extract` can
  # properly locate them and pull them out into the translation
  # files
  def translated_difficulty(opportunity) do
    case opportunity.level do
      1 -> gettext("difficulty-starter")
      5 -> gettext("difficulty-intermediate")
      9 -> gettext("difficulty-advanced")
      _ -> gettext("difficulty-unknown")
    end
  end

  @doc """
  Generate the HTML for the toggable difficulty selection
  """
  def level_selectors(conn) do
    current_selection = selected_levels(conn)

    [level_selector(1, current_selection),
     level_selector(5, current_selection),
     level_selector(9, current_selection)]
  end

  defp level_badge(_level, false), do: "badge-disabled"
  defp level_badge(level, true), do: "badge-#{level}"

  defp level_selector(level, current_selection) do
    [badge, level_params] =
      if level in current_selection do
        [level_badge(level, true), current_selection -- [level]]
      else
        [level_badge(level, false), [level|current_selection]]
      end

    query_params = %{level: Enum.join(level_params, ",")}

    :span
    |> content_tag(translated_difficulty(%{level: level}), class: "badge #{badge}")
    |> link(to: Web.Router.Helpers.opportunities_path(Endpoint, :index, query_params))
  end

  defp selected_levels(%{query_params: params}), do: selected_levels(params)
  defp selected_levels(%{"level" => ""}), do: []
  defp selected_levels(params) do
    params
    |> Map.get("level", "1,5,9")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def translated_type(%{type: "type-bug"}), do: gettext("type-bug")
  def translated_type(%{type: "type-documentation"}), do: gettext("type-documentation")
  def translated_type(%{type: "type-enhancement"}), do: gettext("type-enhancement")
  def translated_type(%{type: "type-feature"}), do: gettext("type-feature")
  def translated_type(%{type: "type-unknown"}), do: gettext("type-unknown")
end

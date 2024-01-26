defmodule NestedWeb.PageLive do
  @moduledoc false
  use NestedWeb, :live_view
  alias Nested.MailingList

  def render(assigns) do
    ~H"""
    <div class="p-10">
      <h1>Click on add more and change any of the inputs</h1>
      <div class="p-6 border border-gray-500 rounded-lg">
        <div>"Add more" as functional component</div>
        <.simple_form for={@form1} phx-change="validate1">
          <.inputs_for :let={r} field={@form1[:emails]}>
            <input type="hidden" name="mailing_list1[emails_sort][]" value={r.index} />
            <.input field={r[:email]} type="email" placeholder="Email" />
            <.input field={r[:name]} type="text" placeholder="Name" />
            <label>
              <input
                type="checkbox"
                name="mailing_list1[emails_sort][]"
                value={r.index}
                class="hidden"
              />
              <.icon name="hero-x-mark" class="w-6 h-6 relative top-2" />
            </label>
          </.inputs_for>
          <input type="hidden" name="mailing_list1[emails_drop][]" />
          <.add_more />
          <:actions>
            <.button type="submit">Submit</.button>
          </:actions>
        </.simple_form>
      </div>

      <div class="p-6 border border-gray-500 rounded-lg">
        <div>"Add more" as included in the layout</div>
        <.simple_form for={@form2} phx-change="validate2">
          <.inputs_for :let={r} field={@form2[:emails]}>
            <input type="hidden" name="mailing_list2[emails_sort][]" value={r.index} />
            <.input field={r[:email]} type="email" placeholder="Email" />
            <.input field={r[:name]} type="text" placeholder="Name" />
            <label>
              <input
                type="checkbox"
                name="mailing_list2[emails_sort][]"
                value={r.index}
                class="hidden"
              />
              <.icon name="hero-x-mark" class="w-6 h-6 relative top-2" />
            </label>
          </.inputs_for>
          <input type="hidden" name="mailing_list2[emails_drop][]" />

          <label class="block cursor-pointer">
            <input type="checkbox" name="mailing_list2[emails_sort][]" class="hidden" /> add more
          </label>
          <:actions>
            <.button type="submit">Submit</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  defp add_more(assigns) do
    ~H"""
    <label class="block cursor-pointer">
      <input type="checkbox" name="mailing_list1[emails_sort][]" class="hidden" /> add more
    </label>
    """
  end

  def mount(_params, _session, socket) do
    ch = %MailingList{} |> MailingList.changeset()

    {:ok,
     assign(socket,
       form1: to_form(ch, as: :mailing_list1),
       form2: to_form(ch, as: :mailing_list2)
     )}
  end

  def handle_event("validate1", %{"mailing_list1" => params}, socket) do
    ch = %MailingList{} |> MailingList.changeset(params)
    {:noreply, assign(socket, form1: to_form(ch, as: :mailing_list1))}
  end

  def handle_event("validate2", %{"mailing_list2" => params}, socket) do
    ch = %MailingList{} |> MailingList.changeset(params)
    {:noreply, assign(socket, form2: to_form(ch, as: :mailing_list2))}
  end
end

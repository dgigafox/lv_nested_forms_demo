defmodule Nested.MailingList do
  use Ecto.Schema
  import Ecto.Changeset

  defmodule Email do
    use Ecto.Schema

    embedded_schema do
      field(:name, :string)
      field(:email, :string)
    end

    def changeset(model, params \\ %{}) do
      model
      |> cast(params, [:name, :email])
    end
  end

  schema "abstract: mailing_lists" do
    embeds_many(:emails, Email)
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [])
    |> cast_embed(:emails,
      sort_param: :emails_sort,
      drop_param: :emails_drop
    )
  end
end

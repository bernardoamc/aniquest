defmodule Aniquest.User do
  use Aniquest.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :picture, :string
    field :token, :string
    field :token_valid_until, Timex.Ecto.DateTime

    timestamps
  end

  @required_fields ~w(name email picture)
  @optional_fields ~w(token token_valid_until)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def registration_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> add_token
  end

  def generate_token(email) do
    token = Phoenix.Token.sign(Aniquest.Endpoint, "token", email)

    valid_until =
      Timex.DateTime.now
      |> Timex.shift(days: 14)

    %{token: token, token_valid_until: valid_until}
  end

  defp add_token(changeset) do
    %{token: token, token_valid_until: valid_until} = generate_token(changeset.params["email"])

    changeset
      |> put_change(:token, token)
      |> put_change(:token_valid_until, valid_until)
  end
end

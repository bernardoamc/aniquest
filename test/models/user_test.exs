defmodule Aniquest.UserTest do
  use Aniquest.ModelCase

  alias Aniquest.User

  @valid_attrs %{email: "abc@gmail.com", name: "abc", picture: "/picture.png", token: "xyzhka2", token_valid_until: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

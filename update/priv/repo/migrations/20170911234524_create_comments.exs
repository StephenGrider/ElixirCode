defmodule Update.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string

      timestamps()
    end

  end
end

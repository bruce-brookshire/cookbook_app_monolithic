defmodule Cookbook.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  def change do

    create table(:users) do
      add :name_first, :string, length: 50
      add :name_last, :string, length: 50
      add :email, :string, length: 255
      add :password, :string, length: 64
      
      timestamps()
    end

    create unique_index(:users, [:email])

    create table(:shared_cookbooks) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :name, :string, length: 70

      timestamps()
    end

    create table(:cookbook_participants) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :shared_cookbook_id, references(:shared_cookbooks, on_delete: :delete_all)

      timestamps()
    end

    create table(:cookbook_invites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :shared_cookbook_id, references(:shared_cookbooks, on_delete: :delete_all)
      add :is_accepted, :boolean

      timestamps()
    end
  end
end

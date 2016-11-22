defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    alias Discuss.Topic

    def index(conn,_params) do
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    def view(conn, _params) do

    end

    def new(conn, _params) do
        changeset = Topic.changeset( %Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, _post} ->
                conn
                |> put_flash(:info, " - You've added a new topic!")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def delete(conn, _params) do

    end

    def update(conn, %{"id" => topic_id, "topic" => topic}) do
        changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

        case Repo.update(changeset) do
            {:ok, _post} ->
                conn
                |> put_flash(:info, " - Topic updated!")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, " - Something went wrong! Try again, please?")
                |> redirect(to: topic_path(conn, :edit, topic_id))
        end
    end
end

defmodule UpdateWeb.TopicControllerTest do
  use UpdateWeb.ConnCase

  alias Update.Discussions

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:topic) do
    {:ok, topic} = Discussions.create_topic(@create_attrs)
    topic
  end

  describe "index" do
    test "lists all topics", %{conn: conn} do
      conn = get conn, topic_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Topics"
    end
  end

  describe "new topic" do
    test "renders form", %{conn: conn} do
      conn = get conn, topic_path(conn, :new)
      assert html_response(conn, 200) =~ "New Topic"
    end
  end

  describe "create topic" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, topic_path(conn, :create), topic: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == topic_path(conn, :show, id)

      conn = get conn, topic_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Topic"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, topic_path(conn, :create), topic: @invalid_attrs
      assert html_response(conn, 200) =~ "New Topic"
    end
  end

  describe "edit topic" do
    setup [:create_topic]

    test "renders form for editing chosen topic", %{conn: conn, topic: topic} do
      conn = get conn, topic_path(conn, :edit, topic)
      assert html_response(conn, 200) =~ "Edit Topic"
    end
  end

  describe "update topic" do
    setup [:create_topic]

    test "redirects when data is valid", %{conn: conn, topic: topic} do
      conn = put conn, topic_path(conn, :update, topic), topic: @update_attrs
      assert redirected_to(conn) == topic_path(conn, :show, topic)

      conn = get conn, topic_path(conn, :show, topic)
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, topic: topic} do
      conn = put conn, topic_path(conn, :update, topic), topic: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Topic"
    end
  end

  describe "delete topic" do
    setup [:create_topic]

    test "deletes chosen topic", %{conn: conn, topic: topic} do
      conn = delete conn, topic_path(conn, :delete, topic)
      assert redirected_to(conn) == topic_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, topic_path(conn, :show, topic)
      end
    end
  end

  defp create_topic(_) do
    topic = fixture(:topic)
    {:ok, topic: topic}
  end
end

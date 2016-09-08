defmodule DivanoTest do
  use ExUnit.Case
  doctest Divano

  use couchbeam

  @url "http://127.0.0.1:5984"
  @options [ 
    is_ssl: true,
    pool_name: "name"
  ] 

  setup_all do
    {:ok, conn} = Divano.start_link(url: @url, options: @options)
    Divano.stop(conn)
    :ok
  end

  setup context do
    if context[:no_setup] do
      {:ok, %{}}
    else
      {:ok, conn} = Divano.start_link(url: @url, options: @options)
      on_exit(fn -> Divano.stop(conn) end)
      {:ok, %{conn: conn}}
    end
  end

  test "connection to couchDB through couchbeam" do
    {:ok, :something} = couchbeam:server_connection(url, Options)
  end

  test "start_link/2: not specifying a database" do
    {:ok, conn} = Divano.start_link(url: @url, options: @options)
    ##assert something
  end
end

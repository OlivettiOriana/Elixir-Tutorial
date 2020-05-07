defmodule ApiResponse do
  @moduledoc """
  Documentation for `ApiResponse`.


  Given a tuple with a status(atom) and some data(map) the functions will return a message according to the status.


  All these functions work the same, the difference is their inner logic.

  ## Parameters
  - a_tuple: The status of the API REST and the Data it may return.

  ## Examples

      iex> ApiResponse.handle_api_response_func({:ok, %{"data" => 1}})
      "Success"

      iex> ApiResponse.handle_api_response_case({:error, %{"data" => 1}})
      "Error"

      iex> ApiResponse.handle_api_response_cond({:warn, %{"data" => 1}})
      "Warning"

      iex> ApiResponse.handle_api_response_if({:what, %{"data" => 1}})
      "No matches were found"

  """

  def handle_api_response_func(a_tuple)
  def handle_api_response_func({:ok, _data}), do: "Success"
  def handle_api_response_func({:error, _data}), do: "Error"
  def handle_api_response_func({:warn, _data}), do: "Warning"
  def handle_api_response_func({_status, _data}), do: "No matches were found"

  def handle_api_response_case(a_tuple)
  def handle_api_response_case({status, data}) do
    case {status, data} do
      {:ok, _data} -> "Success"
      {:error, _data} -> "Error"
      {:warn, _data} -> "Warning"
      _ -> "No matches were found"
    end
  end

  def handle_api_response_cond(a_tuple)
  def handle_api_response_cond({status, _data}) do
    cond do
      status == :ok -> "Success"
      status == :error -> "Error"
      status == :warn -> "Warning"
      true -> "No matches were found"
    end
  end

  def handle_api_response_if(a_tuple)
  def handle_api_response_if({status, _data}) do
    if status == :ok, do: "Success",
    else: if status == :error, do: "Error",
      else: if status == :warn, do: "Warning",
        else: "No matches were found"
  end

end

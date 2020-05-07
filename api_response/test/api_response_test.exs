defmodule ApiResponseTest do
  use ExUnit.Case
  doctest ApiResponse

  test "testing SUCCESS message" do
    assert ApiResponse.handle_api_response_func({:ok, %{"data" => 1}}) == "Success"
    assert ApiResponse.handle_api_response_case({:ok, %{"data" => 1}}) == "Success"
    assert ApiResponse.handle_api_response_cond({:ok, %{"data" => 1}}) == "Success"
    assert ApiResponse.handle_api_response_if({:ok, %{"data" => 1}}) == "Success"
  end

  test "testing ERROR message" do
    assert ApiResponse.handle_api_response_func({:error, %{"data" => 1}}) == "Error"
    assert ApiResponse.handle_api_response_case({:error, %{"data" => 1}}) == "Error"
    assert ApiResponse.handle_api_response_cond({:error, %{"data" => 1}}) == "Error"
    assert ApiResponse.handle_api_response_if({:error, %{"data" => 1}}) == "Error"
  end

  test "testing WARNING message" do
    assert ApiResponse.handle_api_response_func({:warn, %{"data" => 1}}) == "Warning"
    assert ApiResponse.handle_api_response_case({:warn, %{"data" => 1}}) == "Warning"
    assert ApiResponse.handle_api_response_cond({:warn, %{"data" => 1}}) == "Warning"
    assert ApiResponse.handle_api_response_if({:warn, %{"data" => 1}}) == "Warning"
  end

  test "testing NOT FOUND message" do
    assert ApiResponse.handle_api_response_func({:what, %{"data" => 1}}) == "No matches were found"
    assert ApiResponse.handle_api_response_case({:what, %{"data" => 1}}) == "No matches were found"
    assert ApiResponse.handle_api_response_cond({:what, %{"data" => 1}}) == "No matches were found"
    assert ApiResponse.handle_api_response_if({:what, %{"data" => 1}}) == "No matches were found"
  end
end

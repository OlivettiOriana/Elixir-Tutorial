defmodule AwsHandler do
  @moduledoc """
  Documentation for `AwsHandler`.
  """

  @doc """
  Uploads a file to the AWS S3.

  ## Parameters

  - file_path: The path where the file that you want to upload is.
  - bucket_name: The name of the bucket where you want to upload the file.
  - storage_path: The path where you want to store the file.

  ## Examples

      iex> AwsHandler.upload_file("README.md", "elixir-trainings", "Oriana/Read.md")
      {:ok, "File uploaded successfully"}

  """
  def upload_file(file_path, bucket_name, storage_path) do
    case File.read(file_path) do
      {:ok, binary} -> upload_file_s3(binary, bucket_name, storage_path)
      {:error, _reason} -> {:error, "File not found."}
    end
  end

  defp upload_file_s3(file, bucket, path) do
    if exists_bucket?(bucket) do
      ExAws.S3.put_object(bucket, path, file)
      |> ExAws.request()
      |> case do
        {:ok, _data} -> {:ok, "File uploaded successfully"}
        {:error, {http_error, code, _}} -> {:error, "#{http_error} #{code}"}
        _ -> {:error, "We didn't expect that"}
      end
    else
      "#{bucket} does not exist."
    end
  end

  @doc """
  Checks if the given bucket exists.

  ## Parameters

  - bucket_name: The name of the bucket you want to know whether it exists or not.

  ## Examples

      iex> AwsHandler.exists_bucket?("elixir-trainings")
      true

  """
  def exists_bucket?(bucket_name) do
    ExAws.S3.head_bucket(bucket_name)
    |> ExAws.request()
    |> case do
      {:ok, _data} -> true
      {:error, _data} -> false
      _ -> nil
    end
  end

  @doc """
  Checks if the given file exists in the given bucket.

  ## Parameters

  - file_path: The path where the file you want to know whether it exists or not is stored.
  - bucket_name: The name of the bucket where the file is thought to be store.

  ## Examples

      iex> AwsHandler.exists_file?("Oriana/README.md", "elixir-trainings")
      true

  """
  def exists_file?(file_path, bucket_name) do
    if exists_bucket?(bucket_name),
      do: check_object_s3(file_path, bucket_name),
      else: {:error, "#{bucket_name} does not exist."}
  end

  defp check_object_s3(file_path, bucket_name) do
    ExAws.S3.head_object(bucket_name, file_path)
    |> ExAws.request()
    |> case do
      {:ok, _data} -> true
      {:error, _data} -> false
      _ -> nil
    end
  end

  @doc """
  Copies a given file. The files can be copied cross-buckets.

  ## Parameters

  - src_bucket: The name of the bucket where the file you want to copy is stored.
  - src_object: The source path where the file you want to copy is stored.
  - dest_bucket: The name of the bucket where you want to copy the file.
  - dest_object: The name you want the file to have once copied.

  ## Examples

      iex> AwsHandler.copy_file("elixir-trainings", "Oriana/README.md", "elixir-trainings", "Oriana/Read.md")
      {:ok, "File copied successfully"}

  """
  def copy_file(src_bucket, src_object, dest_bucket, dest_object) do
    if exists_bucket?(src_bucket) and exists_bucket?(dest_bucket) do
      case exists_file?(src_object, src_bucket) do
        true -> copy_object_s3(src_bucket, src_object, dest_bucket, dest_object)
        false -> {:error, "#{src_object} does not exist."}
        _ -> {:error, "We didn't expect that."}
      end
    else
      {:error, "One of the buckets does not exist."}
    end
  end

  defp copy_object_s3(src_bucket, src_object, dest_bucket, dest_object) do
    ExAws.S3.put_object_copy(dest_bucket, dest_object, src_bucket, src_object)
    |> ExAws.request()
    |> case do
      {:ok, _data} -> {:ok, "File copied successfully"}
      {:error, {http_error, code, _}} -> {:error, "#{http_error} #{code}"}
      _ -> {:error, "We didn't expect that"}
    end
  end

  @doc """
  Returns a list of buckets if request was successful.

  ## Examples

      iex> AwsHandler.get_buckets()
      {:ok, ["cf-templates-531wafcaqlda-us-east-1", "demo.kikker.io", "dev.kikker.io",
      "docs.phinxlabcore.com", "elasticbeanstalk-us-east-1-615264695120",
      "elasticbeanstalk-us-east-2-615264695120",
      "elasticbeanstalk-us-west-1-615264695120", "elixir-trainings", "fibran-dev",
      "free-bucket-phinx", "gcaba-conferencia-images", "habitat-dashboard-dev",
      "habitat-dev-test", "kikker-dashboard-demo", "kikker-dashboard-dev",
      "kikker-images", "kikker.io", "odoo-db-original", "oned.cloud",
      "people.phinxlabcore.com", "phinx-docs", "phinxlab.com",
      "ps-logistics.com.ar", "pulumi-bucket-7b2cc3f", "pulumi-react-bucket-670a6f9",
      "reactlibbyboilerplate-dev-test",
      "rekognition-video-console-demo-iad-615264695120-ebtkfn84e9xohm",
      "turnero-dev", "ui-kit.phinxlabcore.com", "wallet-app-assets",
      "wallet-mobile-dev-20190823004422-deployment",
      "wallet-omar-project-dev-20190823183324-deployment", "wallet-qr-code",
      "walletomarprojectd5ec4fe7verificationbucket-dev", "wellness-client-dev",
      "wellness-coach-dev", "www.admin.gcaba-conferencias.phinxlabcore.com",
      "www.dev.patag0n.com", "www.gcaba-conferencias.phinxlabcore.com"]}

  """
  def get_buckets() do
    ExAws.S3.list_buckets()
    |> ExAws.request()
    |> case do
      {:ok, %{body: %{buckets: buckets}}} ->
        {:ok, Enum.map(buckets, fn %{name: name} -> name end)}

      {:error, {http_error, code, _}} ->
        {:error, "#{http_error} #{code}"}

      _ ->
        {:error, "We didn't expect that"}
    end
  end

  @doc """
  Returns a list of files of a given bucket if request was successful.

  ## Examples

      iex> AwsHandler.get_files("elixir-trainings")
      {:ok, ["Oriana/", "Oriana/READ.md", "Oriana/README.md", "Oriana/Read.md",
        "Oriana/mix.lo", "Oriana/mix.loc", "cesar/mix.lock", "fabian/",
        "fabian/mario.text", "fabian/mario.txt", "grosendo/mix.lock",
        "ivan/README.md", "joaquin/", "joaquin/README.md", "joaquin/hi",
        "joaquin/mix.exs", "joaquín/", "juan/", "lucas-delrio/",
        "lucas-delrio/README.md", "lucas-delrio/elixir-commands.md", "mariano/",
        "omar/README.md", "omar/mix.lock", "pablo/../readme.md",
        "pablo/./uploader.ex", "pablo/uploader.ex", "richard/rich_upload.txt"]}

  """
  def get_files(bucket_name) do
    if exists_bucket?(bucket_name),
      do: get_objects_s3(bucket_name),
      else: {:error, "#{bucket_name} does not exist."}
  end

  defp get_objects_s3(bucket_name) do
    ExAws.S3.list_objects(bucket_name)
    |> ExAws.request()
    |> case do
      {:ok, %{body: %{contents: files}}} -> {:ok, Enum.map(files, fn %{key: name} -> name end)}
      {:error, {http_error, code, _}} -> {:error, "#{http_error} #{code}"}
      _ -> {:error, "We didn't expect that"}
    end
  end
end

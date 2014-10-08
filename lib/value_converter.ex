defmodule ValueConverter do
  @moduledoc """
  Useful utility for converting numbers to lists for binary transfer
  """

  @doc """
  converts a signed byte to a single item list. Will not accept
  integers greater than 128 and less than -127.

  ## Examples
  
  iex> ValueConverter.convert_byte(100)
  [100]

  iex> ValueConverter.convert_byte(-100)
  [-100]
  """
  def convert_byte(value) when value < 128 and value > -127 do
    [value]  
  end

  @doc """
  converts a unsigned byte to a single item list. Will not accept
  integers greater than 256 and less than 0

  ## Examples

  iex> ValueConverter.convert_unsigned_byte(200)
  [200]
  """
  def convert_unsigned_byte(value) when value < 256 and value > -1 do
    [value]
  end

  @doc """
  converts a signed short to a 2 item list represented as bytes. 
  Will not accept integers greater than 65,536 and less than 0

  ## Examples

  iex> ValueConverter.convert_unsigned_short(32490)
  [126, 234]
  """
  def convert_unsigned_short(value) when value < 65_536 and value > -1 do
    :erlang.term_to_binary(value)
      |> :erlang.binary_to_list
      |> Enum.drop(4)
  end

  @doc """
  converts a signed integer to a 4 item list represented as bytes. 
  Will not accept integers greater than 2,147,483,648 and less than -2,147,483,649

  ## Examples

  iex> ValueConverter.convert_int(32490)
  [0,0,126,234]
  """
  def convert_int(value) when value < 2_147_483_648 and value > -2_147_483_649 do
    :erlang.term_to_binary(value)
      |> :erlang.binary_to_list
      |> Enum.drop(2)
  end

  @doc """
  converts a unsigned integer to a 6 item list represented as bytes. 
  Will not accept integers greater than 4,294,967,296 and less than -1

  ## Examples

  iex> ValueConverter.convert_unsigned_int(4_294_967_295)
  [4, 0, 255, 255, 255, 255]
  """
  def convert_unsigned_int(value) when value < 4_294_967_296 and value > -1 do
    :erlang.term_to_binary(value)
      |> :erlang.binary_to_list
      |> Enum.drop(2)
  end

  @doc """
  converts a float to a 8 item list represented as bytes. 

  ## Examples

  iex> ValueConverter.convert_float(521.256)
  [64, 128, 74, 12, 73, 186, 94, 53]
  """
  def convert_float(value) do
    :erlang.term_to_binary(value)
      |> :erlang.binary_to_list
      |> Enum.drop(2)
      |> pad_list(8)
  end

  @doc """
  Takes a list the with length of 2 and converts the contained bytes
  to an integer

  ## Examples

  iex> ValueConverter.list_to_short([126,234])
  32490
  """
  def list_to_short(list) do
    list = pad_list(list, 4)
    list = [131, 98] ++ list
    list_to_term(list)
  end

  @doc """
  Takes a list the with length of 4 and converts the contained bytes
  to an integer

  ## Examples

  iex> ValueConverter.list_to_int([32,82,126,234])
  542277354

  iex> ValueConverter.list_to_int([4, 1, 29, 82, 12, 235])
  -3943453213
  """
  def list_to_int(list) do
    list = pad_list(list, 4)
    if(length(list) <= 4) do
      list_to_short(list)
    else 
      list = [131, 110] ++ list
      list_to_term(list)
    end
  end

  @doc """
  Takes a list the with any length contained bytes
  to a float

  ## Examples

  iex> ValueConverter.list_to_float([192, 227, 65, 81, 7, 53, 126, 103])
  -39434.53213

  iex> ValueConverter.list_to_float([65, 73, 102, 205, 68, 28, 213, 250])
  3329434.53213
  """
  def list_to_float(list) do
    list = pad_list(list, 8)
    list = [131, 70] ++ list
    list_to_term(list)
  end

  defp list_to_term(list) do
    :erlang.list_to_binary(list)
      |> :erlang.binary_to_term([:safe])
  end

  defp pad_list(list, length) do
    if(length(list) < length) do
      pad_list([0] ++ list, length)
    else
      list
    end
  end
end


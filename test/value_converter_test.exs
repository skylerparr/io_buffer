defmodule ValueConverterTest do
  use ExUnit.Case
  doctest ValueConverter

  test "should convert a byte to a 1 length list" do
    list = ValueConverter.convert_byte(100)
    assert length(list) == 1
    assert 100 == hd list
  end

  test "should not accept integer larger than 127 for a byte" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_byte(128) end
  end

  test "should not accect integer less than -127 for a byte" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_byte(-127) end
  end

  test "should convert an unsigned byte to a 1 length list" do
    list = ValueConverter.convert_unsigned_byte(200)
    assert length(list) == 1
    assert 200 == hd list
  end

  test "should not accept integer greater than 255 for unsigned byte" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_unsigned_byte(256) end
  end

  test "sholud not accept integer less than 0 for unsigned byte" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_unsigned_byte(-1) end
  end

  test "should convert 2 item list to integer" do
    assert 43932 == ValueConverter.list_to_short([171,156])
  end

  test "should convert an unsigned short to a 2 length list" do
    list = ValueConverter.convert_unsigned_short(1293)
    assert length(list) == 2
    assert 1293 == ValueConverter.list_to_short(list)
    list = ValueConverter.convert_unsigned_short(5)
    assert length(list) == 2
    assert 5 == ValueConverter.list_to_short(list)
  end

  test "should not accept integer larger than 65,536 for an unsigned short" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_unsigned_short(65_536) end
  end

  test "should not accept integer less that -1 for an unsigned short" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_unsigned_short(-1) end
  end

  test "should convert 4 item list to integer" do
    assert 165532147 == ValueConverter.list_to_int([9, 221, 209, 243])
  end

  test "should convert 8 item list to float" do
    assert 3329434.53213 == ValueConverter.list_to_float([65, 73, 102, 205, 68, 28, 213, 250])
  end

  test "should convert an int to a 4 length list" do
    list = ValueConverter.convert_int(29348)
    assert length(list) == 4
    assert 29348 == ValueConverter.list_to_int(list)
    list = ValueConverter.convert_int(29)
    assert length(list) == 4
    assert 29 == ValueConverter.list_to_int(list)
  end

  test "should not accept integer larger than 2,147,483,648 for an int" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_int(2_147_483_648) end
  end

  test "should not accept integer less that -2,147,483,649 for an int" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_int(-2_147_483_649) end
  end

  test "should convert an unsigned int to a 6 length list" do
    list = ValueConverter.convert_int(24239348)
    assert length(list) == 4
    assert 24239348 == ValueConverter.list_to_int(list)
  end

  test "should not accept integer larger than 4,294,967,296 for an int" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_int(4_294_967_296) end
  end

  test "should not accept integer less that -1 for an int" do
    assert_raise FunctionClauseError, fn -> ValueConverter.convert_unsigned_int(-1) end
  end
  
  test "should convert float to a 8 length list" do
    list = ValueConverter.convert_float(2910.23193)
    assert length(list) == 8
    assert 2910.23193 == ValueConverter.list_to_float(list)
  end

  test "should pad list with zeros" do
    list = ValueConverter.pad_list([0,0,0,8], 6)
    assert list == [0,0,0,0,0,8]
  end

  test "should un-pad list by chomping off the head" do
    list = ValueConverter.pad_list([0,0,0,8], 2)
    assert list == [0,8]
  end
end

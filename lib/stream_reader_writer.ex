defmodule StreamReaderWriter do
  def read_byte(input) do
    input.read(1)
  end

  def read_unsigned_byte(input) do
    input.read(1)
  end

  def read_short(input) do
    input.read(2)
  end

  def read_unsigned_short(input) do
    input.read(2)
  end

  def read_int(input) do
    input.read(4)
  end

  def read_unsigned_int(input) do
    input.read(4)
  end

  def read_float(input) do
    input.read(8)
  end

  def read_double(input) do
    input.read(8)
  end

  def write_byte(output, byte) do
    output.write(ValueConverter.convert_byte(byte))
  end

  def write_unsigned_byte(output, byte) do
    output.write(ValueConverter.convert_unsigned_byte(byte))
  end

  def write_short(output, short) do
    output.write(ValueConverter.convert_unsigned_short(short))
  end

  def write_unsigned_short(output, short) do
    output.write(ValueConverter.convert_unsigned_short(short))
  end

  def write_int(output, int) do
    output.write(ValueConverter.convert_int(int))
  end

  def write_unsigned_int(output, int) do
    output.write(ValueConverter.convert_unsigned_int(int))
  end

  def write_float(output, float) do
    output.write(ValueConverter.convert_float(float))
  end

  def write_double(output, double) do
    write_float(output, double)
  end
end

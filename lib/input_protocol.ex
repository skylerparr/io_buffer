defprotocol InputProtocol do
  @doc """
  returns the number of bytes specified by length
  """
  def read(length)
end

defprotocol OutputProtocol do
  @doc """
  writes the value specified as a list of bytes
  """
  def write(list)
end

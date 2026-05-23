# @private
class Zeitwerk::Loader::ConstantPathValidator # :nodoc
  CNAME_VALIDATOR = Module.new.freeze #: Module
  private_constant :CNAME_VALIDATOR

  # Technically, this validation works with symbols, but API boundary restricts
  # input to strings, so we assume strings, and we test strings.
  #
  #: (String) -> String ! NameError
  def validate!(possible_cpath)
    CNAME_VALIDATOR.const_defined?(possible_cpath, false)
    possible_cpath.delete_prefix('::')
  end
end

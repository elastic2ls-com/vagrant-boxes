node default {
  #
  # First test: ntp. This includes the puppetlabs ntp module, which should
  # pick up its parameters from Hiera automatically.
  #
  #include ntp
  class { "ntp": }
}

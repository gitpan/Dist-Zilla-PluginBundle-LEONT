package Dist::Zilla::PluginBundle::LEONT::PP;
{
  $Dist::Zilla::PluginBundle::LEONT::PP::VERSION = '0.007';
}

use Moose;

extends 'Dist::Zilla::PluginBundle::LEONT';

has '+install_tool' => (
	default => 'eumm',
);

1;

# ABSTRACT: Legacy plugin bundle for pure-perl modules


__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::LEONT::PP - Legacy plugin bundle for pure-perl modules

=head1 VERSION

version 0.007

=head1 AUTHOR

Leon Timmermans <leont@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


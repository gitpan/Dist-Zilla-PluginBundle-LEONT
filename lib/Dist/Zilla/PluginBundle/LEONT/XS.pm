package Dist::Zilla::PluginBundle::LEONT::XS;
{
  $Dist::Zilla::PluginBundle::LEONT::XS::VERSION = '0.012';
}

use Moose;

extends 'Dist::Zilla::PluginBundle::LEONT';

has '+install_tool' => (
	default => 'mb',
);

1;

# ABSTRACT: Legacy plugin bundle for xs modules

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::PluginBundle::LEONT::XS - Legacy plugin bundle for xs modules

=head1 VERSION

version 0.012

=head1 AUTHOR

Leon Timmermans <leont@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

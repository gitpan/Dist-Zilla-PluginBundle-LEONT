package Dist::Zilla::PluginBundle::LEONT;
{
  $Dist::Zilla::PluginBundle::LEONT::VERSION = '0.012';
}
use strict;
use warnings;

use Moose;
with qw/Dist::Zilla::Role::PluginBundle::Easy Dist::Zilla::Role::PluginBundle::PluginRemover Dist::Zilla::Role::PluginBundle::Config::Slicer/;

has install_tool => (
	is      => 'ro',
	isa     => 'Str',
	lazy    => 1,
	default => sub {
		my $self = shift;
		$self->payload->{install_tool};
	},
);

has fast => (
	is      => 'ro',
	isa     => 'Bool',
	lazy    => 1,
	default => sub {
		my $self = shift;
		$self->payload->{fast};
	},
);

my @plugins_early = (qw/
GatherDir
PruneCruft
ManifestSkip
MetaYAML
License
Readme
ExtraTests
/,
[ ExecDir => { dir => 'script' } ],
qw/
ShareDir
Manifest

AutoPrereqs
MetaJSON
Repository
Bugtracker
Git::NextVersion
MetaProvides::Package

NextRelease
CheckChangesHasContent
/);

# AutoPrereqs should be before installtool (for BuildSelf), InstallGuide should be after it.
# UploadToCPAN should be after @Git

my @plugins_late = qw/
TestRelease
ConfirmRelease
UploadToCPAN

PodWeaver
PkgVersion

PodSyntaxTests
PodCoverageTests
Test::Compile
/;

my @bundles = qw/Git/;

my %tools = (
	eumm => [ 'MakeMaker' ],
	mb   => [ 'ModuleBuild' ],
	mbc  => [ qw/ModuleBuild::Custom Meta::Dynamic::Config/ ],
	mbt  => [ 'ModuleBuildTiny' ],
	self => [ 'BuildSelf' ],
	none => [],
);

sub configure {
	my $self = shift;

	my $tool = $tools{ $self->install_tool };
	confess 'No known tool ' . $self->install_tool if not $tool;
	$self->add_plugins(@plugins_early);
	$self->add_plugins($self->fast ? 'MinimumPerlFast' : 'MinimumPerl');
	$self->add_plugins(@{$tool});
	$self->add_bundle("\@$_") for @bundles;
	$self->add_plugins(@plugins_late);
	$self->add_plugins('InstallGuide') if @{$tool};
	return;
}

1;

# ABSTRACT: LEONT's dzil bundle

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::PluginBundle::LEONT - LEONT's dzil bundle

=head1 VERSION

version 0.012

=head1 DESCRIPTION

This is currently identical to the following setup:

    ; @Basic except for MakeMaker and ExecDir
    [GatherDir]
    [PruneCruft]
    [ManifestSkip]
    [MetaYAML]
    [License]
    [Readme]
    [ExtraTests]
    [ShareDir]
    [Manifest]
    [TestRelease]
    [ConfirmRelease]
    [UploadToCPAN]

    [ExecDir]
    dir = script

    [AutoPrereqs]
    [MetaJSON]
    [MetaResources]
    [Repository]
    [Bugtracker]
    [MinimumPerl]
    [Git::NextVersion]
    
    [NextRelease]
    [CheckChangesHasContent]

    ($install_tool dependent modules)

    [InstallGuide]

    [PodWeaver]
    [PkgVersion]
    
    [PodSyntaxTests]
    [PodCoverageTests]
    [Test::Compile]
    
    [@Git]

The install_tool parameter can currently have 5 different values:

=over 4

=item * eumm

Use ExtUtils::MakeMaker

=item * mb

Use Module::Build

=item * mbc

Use Module::Build with the ModuleBuild::Custom plugin

=item * mbt

Use Module::Build::Tiny

=item * self

Use the installing module to bootstrap itself

=back

=for Pod::Coverage configure

=head1 AUTHOR

Leon Timmermans <leont@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Leon Timmermans.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

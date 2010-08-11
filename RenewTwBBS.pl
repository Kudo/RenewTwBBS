#!/usr/bin/perl

#
#   RenewTwBBS.pl - Auto twbbs domain renewer
#
#   Copyright (C) 2010  Kudo Chien (Chih-Kuan Chien)
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

use strict;
use warnings;
use WWW::Mechanize;

our $VERSION = '0.01';

my $USERNAME = "YourUsername";
my $PASSWORD = "YourPassword";

my $twbbsURL = 'http://twbbs.org/';

sub main() {
    my $mech = WWW::Mechanize->new(
	quiet => 1,
    );

    $mech->agent_alias('Windows IE 6');

    $mech->get($twbbsURL);

    $mech->submit_form(
	form_id => 'user-login-form',
	fields => {
	    name => $USERNAME,
	    pass => $PASSWORD
	}
    );

    $mech->get($twbbsURL . '?q=bbs_renew');
    
    while ((my $form = $mech->form_with_fields({ extend_confirm => "1" }))) {
	printf("To renew: %s.%s\n", $form->value('ext_host'), $form->value('main_dn'));
	$form->click();
    }
}

&main();

#!/usr/bin/perl -w
use strict;
use SDL;
use SDL::Event;
use SDL::Events;
use SDL::ActiveEvent;
use SDL::ExposeEvent;
use SDL::JoyAxisEvent;
use SDL::JoyBallEvent;
use SDL::JoyButtonEvent;
use SDL::JoyHatEvent;
use SDL::KeyboardEvent;
use SDL::MouseButtonEvent;
use SDL::MouseMotionEvent;
use SDL::QuitEvent;
use SDL::ResizeEvent;
use SDL::SysWMEvent;
use SDL::UserEvent;
use SDL::Video;
use Test::More;

plan ( tests => 33 );

my @done =qw/
pump_events 
/;

my @done_event =qw/
type
active
key
motion
button
jaxis
jball
jhat
jbutton
resize
expose
quit
user
syswm
/;

use_ok( 'SDL::Events' ); 
use_ok( 'SDL::Event' ); 
use_ok( 'SDL::ActiveEvent' ); 
use_ok( 'SDL::ExposeEvent' ); 
use_ok( 'SDL::JoyAxisEvent' ); 
use_ok( 'SDL::JoyBallEvent' ); 
use_ok( 'SDL::JoyButtonEvent' ); 
use_ok( 'SDL::JoyHatEvent' ); 
use_ok( 'SDL::KeyboardEvent' ); 
use_ok( 'SDL::MouseButtonEvent' ); 
use_ok( 'SDL::MouseMotionEvent' ); 
use_ok( 'SDL::QuitEvent' ); 
use_ok( 'SDL::ResizeEvent' ); 
use_ok( 'SDL::SysWMEvent' ); 
use_ok( 'SDL::UserEvent' ); 
can_ok( 'SDL::Events',           @done); 
can_ok( 'SDL::Event',            @done_event);
can_ok( 'SDL::ActiveEvent',      qw/type gain state/);
can_ok( 'SDL::ExposeEvent',      qw/type/);
can_ok( 'SDL::JoyAxisEvent',     qw/type which axis value/);
can_ok( 'SDL::JoyBallEvent',     qw/type which ball xrel yrel/);
can_ok( 'SDL::JoyButtonEvent',   qw/type which button state/);
can_ok( 'SDL::JoyHatEvent',      qw/type which hat value/);
can_ok( 'SDL::KeyboardEvent',    qw/type state keysym/);
can_ok( 'SDL::MouseButtonEvent', qw/type which button state x y/);
can_ok( 'SDL::MouseMotionEvent', qw/type state x y xrel yrel/);
can_ok( 'SDL::QuitEvent',        qw/type/);
can_ok( 'SDL::ResizeEvent',      qw/type w h/);
can_ok( 'SDL::SysWMEvent',       qw/type msg/);
can_ok( 'SDL::UserEvent',        qw/type code data1 data2/);

SDL::init(SDL_INIT_VIDEO);                                                                          

SDL::Video::set_video_mode(640,480,32, SDL_SWSURFACE);

is(SDL::Events::pump_events(), undef,  '[pump_events] Returns undef');

=pod

my $events = SDL::Event->new();
my $num_peep_events = SDL::Events::peep_events( $events, 127, SDL_PEEKEVENT, SDL_ALLEVENTS);
is($num_peep_events >= 0, 1,  '[peep_events] Size of event queue is ' . $num_peep_events);

my $event = SDL::Event->new();
my $value = SDL::Events::poll_event($event);
is(($value == 1) || ($value == 0), 1,  '[poll_event] Returns 1 or 0');


my $event2 = SDL::Event->new();
is(SDL::Events::push_event($event2), 0,  '[push_event] Returns 0 on success');
my $event3 = SDL::Event->new();
is(SDL::Events::push_event($event3), 0,  '[push_event] Returns 0 on success');


my $events2 = SDL::Event->new();
my $num_peep_events2 = SDL::Events::peep_events( $events2, 127, SDL_PEEKEVENT, SDL_ALLEVENTS);
is($num_peep_events2 > $num_peep_events, 1,  '[peep_events] Size of event queue is ' . $num_peep_events2."\t". SDL::get_error());



my $events3 = SDL::Event->new();
$num_peep_events = SDL::Events::peep_events( $events3, 1, SDL_ADDEVENT, SDL_ALLEVENTS);
is($num_peep_events, 1,  '[peep_events] Added 1 event to the back of the queue');

my $events4 = SDL::Event->new();
$num_peep_events = SDL::Events::peep_events( $events4, 1, SDL_GETEVENT, SDL_ALLEVENTS);
is($num_peep_events, 1,  '[peep_events] Got 1 event from the front of the queue');



my $event4 = SDL::Event->new();
is(SDL::Events::wait_event($event4), 1,  '[wait_event] Returns 1 on success');
is(SDL::Events::wait_event(), 1,  '[wait_event] Returns 1 on success');

=cut


my @left = qw/
peep_events 
poll_event
push_event
wait_event
seteventfilter 
eventstate 
getkeystate 
getmodstate 
setmodstate 
getkeyname 
enableunicode 
enablekeyrepeat 
getmousestate 
getrelativemousestate 
getappstate 
joystickeventstate 
StartTextInput 
StopTextInput 
SetTextInputRect 
/;

my $why = '[Percentage Completion] '.int( 100 * ($#done +1 ) / ($#done + $#left + 2  ) ) .'% implementation. '.($#done +1 ).'/'.($#done+$#left + 2 ); 

TODO:
{
	local $TODO = $why;
	pass "\nThe following functions:\n".join ",", @left; 
}
	if( $done[0] eq 'none'){ diag '0% done 0/'.$#left } else { diag  $why} 


pass 'Are we still alive? Checking for segfaults';
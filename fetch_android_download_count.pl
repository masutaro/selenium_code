#!/opt/local/bin/perl

use strict;
use warnings;
use Encode qw(encode);
use Selenium::Remote::Driver;

my $driver = Selenium::Remote::Driver->new(
    'browser_name'       => 'firefox',
    'remote_server_addr' => 'localhost:4444'
);
$driver->get('https://market.android.com/publish/');

#
# ログイン
#
my $email    = $driver->find_element('Email', 'id');
$email->send_keys('your_address@example.com');

my $password = $driver->find_element('Passwd', 'id');
$password->send_keys('your_password');

my $submit   = $driver->find_element('signIn', 'id');
$submit->click;

#
# JSの処理が終わるまで待つ。通信環境に応じて値は適宜変更。
#
sleep 20;

#
# ダウンロード数情報を取得
#
my $download   = $driver->find_element('GGJ3GERDOX', 'class')->get_text;
$download      = encode('utf8', $download);
my ($sum)      = $download =~ m!合計インストール数（ユーザー）: ([0-9]+)!;
my ($total)    = $download =~ m!([0-9]+) 総!;

#
# printfして終わり。自分の本番環境ではメール送信してる。
#
printf("合計インストール数(ユーザー):%s\n", $sum);
printf("総インストール数(端末):%s\n", $total);

#!/opt/local/bin/perl

use strict;
use warnings;
use Selenium::Remote::Driver;

my $driver = Selenium::Remote::Driver->new(
    'browser_name'       => 'firefox',
    'remote_server_addr' => 'localhost:4444'
);
$driver->get('https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa');

#
# ログイン
#
my $email    = $driver->find_element('accountname', 'id');
$email->send_keys('your_address@example.com');

my $password = $driver->find_element('accountpassword', 'id');
$password->send_keys('your_password');
$password->submit;

my $link = $driver->find_element(
    '/html/body/table/tbody/tr/td/table/tbody/tr[7]/td[2]/table/tbody/tr/td/table/tbody/tr[2]/td[2]/a'
);
$link->click;

#
# JSの処理が終わるまで待つ。通信環境に応じて適宜値を変更。
#
sleep 30;

#
# ダウンロード数情報を取得
#
my $download   = $driver->find_element(
    '/html/body/form/div[2]/div[3]/div[2]/div[5]/div/div[2]/div[2]/div/div[2]/div/table[2]/tbody/tr/td[2]'
)->get_text;

#
# printfして終わり。自分の本番環境ではメール送信してる。
#
printf("Units:%s\n", $download);

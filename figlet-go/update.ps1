Import-Module au

$releases = 'https://github.com/lukesampson/figlet/releases/latest'

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing #1
	$regex = '\.zip$'
	$url = $download_page.links | ? href -Match $regex | select -First 1 -expand href #2
	$version = $url -split '-|.zip' | select -Last 1 -Skip 2 #3
	return @{ Version = $version; URL32 = 'https://github.com' + $url }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt'    = @{
			'(?i)(\s+x32:).*'   = "`${1} $($Latest.URL32)"
			'(?i)(checksum32:).*' = "`${1} $($Latest.Checksum32)"
		}
	}
}

Update-Package -ChecksumFor none
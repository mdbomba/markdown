$ScriptVersion = "7.2.53.0.20210110"
Clear-Host
Write-Host -fore Cyan "SCRIPT TO INSTALL CITRIX STOREFRONT"
$catch = start-sleep -milliseconds 1500
$PS_Required = "7.2.53.0"                                  ## This is the required minimum release of LoadMaster PowerShell Module for this script to function
$LM_Required = "7.2.53.0"                                  ## This is the required minimum release of LoadMaster Operating System for this script to function

#Fixes
# - Fix HTML5 with ESP rules ordering 
# - Added SubVS for new ESP auth mode
# - Made optional install of intermediate and root certificates
# - Added check to ensure correct version of Kemp Powershell module and LoadMaster OS is installed

#REQUIREMENTS 
# 1. Text file called “vdiservers.txt.” containing all your VDI Server IP addresses.
# 2. Text file called “storefront.txt.” containing all your StoreFront Servers IP addresses.
# 3. Certificate file in pem or pfx format for virtual service
# 4, CA files for issuing and/or root certificate authority files in base64 format
# 5. Availability of a LDAP or Radius authentication service
# 6. Citrix StoreFront Fully Qualified Domain Name, e.g. citrix.kemptest.com
# 7. Citrix StoreFront URL, e.g. /Citrix/KempWeb
# 8. IP address to assign to Citrix Virtual Service



#####################################################
#Check for Kemp Powershell Build minimum requirements
#####################################################
$PS_R1 = ($PS_Required.Split("."))[0]
$PS_R2 = ($PS_Required.Split("."))[1]
$PS_R3 = ($PS_Required.Split("."))[2]
$PS_R4 = ($PS_Required.Split("."))[3]

#############################
# Ensure module is installed 
#############################

if ((Test-Path "C:\Program Files\WindowsPowerShell\Modules\KEMP.LoadBalancer.Powershell") -or (Test-Path "C:\Program Files (x86)\WindowsPowerShell\Modules\KEMP.LoadBalancer.Powershell")) {
$catch = Remove-Module -Name KEMP.LoadBalancer.Powershell -errorAction SilentlyContinue
$catch = Start-Sleep -Seconds 1
$catch = Import-Module -Name KEMP.LoadBalancer.Powershell -MinimumVersion $PS_Required -ErrorAction SilentlyContinue
}

$PS_Version = $Null
$PS_Version = (Get-Module -name KEMP.LoadBalancer.Powershell).Version
if ($PS_Version -eq $Null) {
write-host -fore Yellow "Kemp PowerShell Module is not properly installed. Please install module version $PS_Required and rerun script"
pause
exit
}
$PS_V1 = ($PS_Version.Major)
$PS_V2 = ($PS_Version.Minor)
$PS_V3 = ($PS_Version.Build)
$PS_V4 = ($PS_Version.Revision)

if (($PS_V1 -ge $PS_R1) -and ($PS_V2 -ge $PS_R2) -and ($PS_V3 -ge $PS_R3) -and ($PS_V4 -ge $PS_R4)) { }
else {
write-host -fore Yellow "WARNING - Minimum Kemp powershell module version is 7.2.$PS_Required.  Script will now terminate. Please install latest Kemp PowerShell Module and rerun script"

exit
}



#################
# Create Log File                                  ## DO NOT UPDATE THIS SECTION
#################
$dd = Get-Date -Format yyMMddhhmmss                ## Get a date time indel to prepend to file name
$logfile = "Citrix_Script_Log_"+$dd+".log"         ## Create a unique log file name including datetime 
add-content -path $logfile -Value "Log file for Citrix Script`nVersion Number = $ScriptVersion"




#########################################################################################################################
#                                               START CONFIGURING VARIABLES
#########################################################################################################################


#############################
# Wait timer between commands 
#############################
$wait = 100                                      ## UPDATE - Set wait state between commands (increase if script generates errors when running) 



#######################
# Script home directory
#######################
$scripthome = "C:\ScriptHome"                    ## UPDATE - Location to hold files and run powershell commands from
set-location -path $scripthome


#####################
# LoadMaster settings
#####################
$LoadmasterIP = "10.10.10.10"                    ## UPDATE - LoadMaster Management IP Address (shared address if HA)
$LoadMasterPort = "443"                          ## UPDATE - Update only if using a nonstandard management port
$SF_File = ".\storefront.txt"                    ## UPPATE - File Name for file containing storefront IP addresses
$VDI_File = ".\vdiservers.txt"                   ## UPPATE - File Name for file containing VDI server IP addresses


#########################
# Citrix Virtual Service settings 
#########################
$VirtualServiceIp = "10.10.10.11"                ## UPDATE - Virtual Service IP (used to publish Citrix StoreFront service)                      
$Use_HTML5 = $True                               ## UPDATE - If set to $True then build HTML5 listeners, if $False use only ICA listeners (Must be $True or $False) 
$Use_LDAP = $True							     ## UPDATE - If set to $True, then use LDAP for user auth to StoreFront (Must be $True or $False)
$Use_Radius = $false                              ## UPDATE - If set to $True, then use Radius for user auth to StoreFront (Must be $True or $False)
                                                 ## NOTE - If $Use_LDAP and $Use_Radius are both set to $False, then do not use LoadMaster Frontend Authentication ESP service
##########################
# Client Side ESP SSO settings 
##########################
$AuthServers = "10.10.10.12"                     ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (One or more IP addresses, space seperated)
$TestAccount = "user@domain.com"        ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (Account used to bind to LDAP or healthcheck LDAP or Radius)
$Domain ="domain.com" 		                 ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (LDAP or Radius SSO Domain)


#########################################
# Citrix Gateway Virtual Service settings
#########################################
$StorePath = "/Citrix/kempWeb"             ## UPDATE - Citrix Store Name URL
$FQDN = "storefront.domain.com"            ## UPDATE - Citrix External FQDN
 
 
$CertFile = "kemp_OpenSSL.pfx"              ## UPDATE - Filename of StoreFront TLS Certficate (place cert in C:\ScriptHome)
$CertName = "kemp_OpenSSL"                  ## UPDATE - Name of StoreFront TLS Certificate to be loaded to LoadMaster                        
                           

#########################################################################################################################
#                                               END CONFIGURE VARIABLES
#########################################################################################################################







#########################################################################################################################
#                                           DO NOT MODIFY SETTINGS BELOW THIS LINE
#########################################################################################################################

############################################
# Check for access to LoadMaster IP address
############################################
add-content -path $logfile -Value "Checking connection to LoadMaster"
write-host -fore Cyan "`nChecking connection to LoadMaster"
$ok = test-connection $LoadMasterIP -quiet -count 1 												# Ping test to see if something is listening to IP address
if ($ok) {
add-content -path $logfile -Value "  Connection to LoadMaster IP address $LoadmasterIP successful"
Write-Host "Connection to LoadMaster IP address $LoadmasterIP successful"
}
else { 
add-content -path $logfile -Value "Script Terminating. LoadMaster IP address $LoadMasterIP is NOT reachable over the network"
Write-Host -fore Red "Script Terminating. LoadMaster IP address $LoadMasterIP is NOT reachable over the network" 
pause
exit
}
 
################################################
# LOGIN to LoadMaster and enable API interface #
################################################
add-content -path $logfile -Value "Making Secure Login Request to LoadMaster"
write-host -fore Cyan "`nMaking Secure Login Request to LoadMaster. Please enter admin userid and password in the dialogue box."
$KempCreds = Get-Credential -message "Enter the LoadMaster admin account name and password"
$Login = Initialize-LmConnectionParameters -Address $LoadmasterIP -LBPort $LoadMasterPort -Credential $KempCreds

###############################################################
# Enable API interface and check to see if login was successful
###############################################################
$eapi = Enable-SecAPIAccess -LoadBalancer $LoadmasterIP -Credential $KempCreds
if ($eapi.ReturnCode -eq "200") {
add-content -path $logfile -Value "  Login to LoadMaster successfull"
write-host "Login to LoadMaster successfull"
}
else {
add-content -path $logfile -Value "Script terminating. Login to LoadMaster unsuccessful"
write-host -fore red "`nSCRIPT TERMINATING. Login to LoadMaster unsuccessful"
pause
exit
}

#######################################################
# Check for minimum LoadMaster Operating System version
#######################################################
$LM_R1 = ($LM_Required.Split("."))[0]
$LM_R2 = ($LM_Required.Split("."))[1]
$LM_R3 = ($LM_Required.Split("."))[2]
$LM_R4 = ($LM_Required.Split("."))[3]

$LM_Version = $Null
$LM_Version = (get-lmallparameters).data.AllParameters.version
$LM_V1 = ($LM_Version.Split("."))[0]
$LM_V2 = ($LM_Version.Split("."))[1]
$LM_V3 = ($LM_Version.Split("."))[2]
$LM_V4 = ($LM_Version.Split("."))[3]

if (($LM_V1 -ge $LM_R1) -and ($LM_V2 -ge $LM_R2) -and ($LM_V3 -ge $LM_R3) -and ($LM_V4 -ge $LM_R4)) { 
add-content -path $logfile -Value "  Verified LMOS version. Version found is $LM_Version"
add-content -path $logfile -Value "  Verified LoadMaster Powershell Module version. Version found is $PS_Version"
write-host -fore cyan "`nVerifying correct LoadMaster firmware version and powershell module version"
write-host  "Verified LMOS version. Required version is $LM_Required. Version found is $LM_Version"
write-host  "Verified LoadMaster PowerShell Module version. Required version is $PS_Required. Version found is $PS_Version"
}
else {
write-host -fore Yellow "`nTERMINATING SCRIPT - Please patch LoadMaster to a minimum of version $LM_Required and rerun script"
exit
}

################################################
# Check to see if certificates already installed
################################################
$doCert = ((get-TLSCertificate -CertName $CertName).ReturnCode -ne "200")
$doCA = ((get-TLSIntermediateCertificate -CertName $CA_Name).ReturnCode -ne "200") 
$doRA = ((get-TLSIntermediateCertificate -CertName $RA_Name).ReturnCode -ne "200")

#####################################
# Standard Settings - Virtual Service 
#####################################
$Use_ESP = $True                                   ## Script Logic will change this to False if both $Use_Radius and $Use_LDAP are set to False
$VSName = "Citrix StoreFront Gateway"              ## Standard value used in script and template
$VSPort = "443"                                    ## Standard value used in script and template
$RSPort = "443"                                    ## Standard value used in script and template

##################################
# Standard Settings - VDI Services 
##################################
$starting_index = 1                               ## Standard value used in script and template
$starting_port = 4431                              ## Standard value used in script and template

######################################
# Standard Settings - VDI 2598 Service 
######################################
$vdi2589_vs_name ="Citrix_Workspace_VDI_"          ## Standard value used in script and template
$vdi2589_RS_Port ="2598"                           ## Standard value used in script and template

#######################################
# Standard Settings - VDI HTML5 Service
#######################################
$vdi8008_vs_name ="Citrix_HTML5_VDI_"              ## Standard value used in script and template
$vdi8008_RS_Port ="8008"                           ## Standard value used in script and template


##############################################################################
# Check for existing Citrix virtual services and if present - TERMINATE SCRIPT
##############################################################################
add-content -path $logfile -Value "Checking for existing Citrix Virtual Service"
$rc = (Get-AdcVirtualService -VirtualService $VirtualServiceIp -VSPort $starting_port -VSProtocol tcp)
if ($rc.ReturnCode -eq 200) {
add-content -path $logfile -Value "  Script Terminating. Existing Citrix virtua service found." 
Write-Host -fore red "`nTERMINATING SCRIPT"
write-host -fore red "LoadMaster has already been configured for Citrix StoreFront"
pause
exit
}

####################################
# Run Sanity Check on variables    #
# Check that vdiservers.txt exists #
# Check that storefront.txt exists #
####################################

if (($Use_Radius.gettype().name -eq "Boolean") -AND ($Use_LDAP.gettype().name -eq "Boolean")) {

  if ($Use_Radius -AND $Use_LDAP) {
  add-content -path $logfile -Value " SCRIPT TERMINATING - USE_RADIUS AND USE_LDAP ARE BOTH SET TO TRUE"
  Write-Host ''
  Write-Host '??????????????????????????????????????????????????????????????'
  Write-Host '? Both $Use_Radius and $Use_LDAP are set to $True.           ?'
  Write-Host '? You need to enable only one SSO protocol, Radius or LDAP.  ?'
  Write-Host '? If one is set to $True, the other must be set to $False.   ?'
  Write-Host '? Script is terminating.                                     ?'
  Write-Host '??????????????????????????????????????????????????????????????'
  Write-Host ''
  pause
  exit 
  } 
  if ((-NOT $Use_Radius) -AND (-NOT $Use_LDAP)) {
  add-content -path $logfile -Value " Running script without use of ESP"
  Write-Host -fore cyan "`nBUILDING CITRIX VIRTUAL SERVICES WITHOUT KEMP EDGE SECURITY PACK"
  $catch = start-sleep -milliseconds 1500
  $Use_ESP = $False
  }
  Else {
  Write-Host -fore cyan "`nBUILDING CITRIX VIRTUAL SERVICES WITH KEMP EDGE SECURITY PACK"
  $catch = start-sleep -milliseconds 1500
  }
}
Else{
  add-content -path $logfile -Value " SCRIPT TERMINATING - USE_RADIUS AND USE_LDAP SETTINGS INCORRECT"
  Write-Host ''
  Write-Host '?????????????????????????????????????????????????????????????????????????????'
  Write-Host '? $Use_Radius and $Use_LDAP must be boolean values set to $True ot $False.  ?'
  Write-Host '? Please adjust valuses to either $True or $False for these variables       ?'
  Write-Host '? Script is terminating.                                                    ?'
  Write-Host '?????????????????????????????????????????????????????????????????????????????'
  Write-Host ''
  pause
  exit 
}

if ( -NOT ((Test-Path .\vdiservers.txt) -AND (Test-Path .\storefront.txt))) {
add-content -path $logfile -Value " SCRIPT TERMINATING - vdiservers.txt or storefront.txt file missing"
Write-Host ""
Write-Host "???????????????????????????????????????????????????????????????????????????????????????????????????"
Write-Host "? Either vdiservers.txt or storefront.txt is not present in the directory the script is being ran ?"
Write-Host "? Change directory to the location holding vdiservers.txt and storefront.txt                      ?"
Write-Host "? Or move/create these files in the current directory                                             ?"
Write-Host "? Please rerun script once above prerequisites are met.                                           ?"
Write-Host "? Script is terminating.                                                                          ?"
Write-Host "???????????????????????????????????????????????????????????????????????????????????????????????????"
Write-Host ""
pause
exit 
}

###################################################################################################
# Check LoadMaster to see if it includes ESP license - if no - set Use_LDAP and Use_Radius to False
###################################################################################################
$License_ESP = (Get-LicenseInfo).data.LicenseInfo.ESP
write-host "`nChecking LoadMaster License for Edge Security Pack (ESP)" 

if ($License_ESP -ne "yes") {
add-content -path $logfile -Value "WARNING - ESP License not found - Resetting Use_LDAP and Use_Radius to False"
write-host "ESP License not found - Resetting Use_LDAP and Use_Radius to False"
$Use_LDAP = $False
$Use_Radius = $False
$Use_ESP = $False
}
else {
add-content -path $logfile -Value "ESP License was found - Honoring settings for Use_LDAP and Use_Radius"
Write-host "ESP License was found. Honoring settings for Use_LDAP and Use_Radius"
}
$catch = start-sleep -milliseconds $wait


###########################################################
# Check to see if certificate files are available if needed
###########################################################

if ( $doRA -AND (-NOT (Test-Path $RA_File))) {
add-content -path $logfile -Value " WARNING - missing certificate file - $RA_File"
$doRA = $False
}

if ( $doCA -AND (-NOT (Test-Path $CA_File))) {
add-content -path $logfile -Value " WARNING - missing certificate file - $CA_File"
$doCA = $False
}

if ( $doCert -AND (-NOT (Test-Path $certfile))) {
add-content -path $logfile -Value " SCRIPT TERMINATING - missing certificate file - $certfile"
Write-Host -fore red "SCRIPT TERMINATING - certificate file named $certfile missing"
pause
exit 
}

##############################################################################
# Read file and extract individual lines that are in IP address or FQDN format
##############################################################################
$SF_asIP = $False
$VDI_asIP = $False
$StoreFrontIP = $null
$StoreFrontIP = New-Object System.Collections.Generic.List[System.Object]
$servers = $null
$servers = New-Object System.Collections.Generic.List[System.Object]
$pattern1 = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
$pattern2 = '^([a-zA-Z0-9._-])+$'

##########################################
# Checking for an IP address pattern match
##########################################
$SF_asIP = ((Select-String -Quiet -path $SF_File -pattern $pattern1) -and (Select-String -Quiet -path $SF_File -pattern $pattern2))
$SF_asFQDN = ((-not $SF_asIP) -AND  (Select-String -Quiet -path $SF_File -pattern $pattern2))
$VDI_asIP = ((Select-String -Quiet -path $VDI_File -pattern $pattern1) -and (Select-String -Quiet -path $SF_File -pattern $pattern2))
$VDI_asFQDN = ((-not $VDI_asIP) -AND  (Select-String -Quiet -path $VDI_File -pattern $pattern2))
if ($VDI_asFQDN) { 
add-content -path $logfile -Value " SCRIPT TERMINATING - VDI File contains host names. Only IP addresses are currently supported"
Write-Host -fore red "SCRIPT TERMINATING - VDI File has contains host names.  Only IP addresses are currently supported. " 
}
if ($SF_asFQDN) { 
add-content -path $logfile -Value " SCRIPT TERMINATING - Storefront File contains host names. Only IP addresses are currently supported"
Write-Host -fore red "SCRIPT TERMINATING - Storefront File has contains host names.  Only IP addresses are currently supported. " 
}
if (-NOT $VDI_asIP) { 
add-content -path $logfile -Value " SCRIPT TERMINATING - VDI File does not contain IP addresses"
Write-Host -fore red "SCRIPT TERMINATING - VDI File does not contain IP addresses" 
}
if (-NOT $SF_asIP) { 
add-content -path $logfile -Value " SCRIPT TERMINATING - Storefront File does not contain IP addresses"
Write-Host -fore red "SCRIPT TERMINATING - Storefront File does not contain IP addresses" 
}

###################################
# Loading StoreFront Info from File
###################################
$in = @(Get-Content -Path $SF_File)
foreach ($item in $in) { if ($item -match $pattern1) {$StoreFrontIP += $item}  }

###################################
# Loading VDI Server Info from File
###################################
$in = @(Get-Content -Path $VDI_File)
foreach ($item in $in) { if ( $item -match $pattern1) {$servers += $item}  }

################################################################################################
# Sanity Check - if no VDI Servers or StoreFront Servers extracted from files - terminate script
#################################################################################################
if ($storefrontip.count -eq 0) {
add-content -path $logfile -Value " SCRIPT TERMINATING - No StoreFront Servers Identified."
Write-Host -fore red "`nERROR - SCRIPT TERMINATING - No StoreFront Servers Identified." ; pause ; exit }
if ($servers.count -eq 0) {
add-content -path $logfile -Value " SCRIPT TERMINATING - No VDI Servers Identified."
Write-Host -fore red "`nERROR - SCRIPT TERMINATING - No VDI Servers Identified." ; pause ; exit }
Write-Host -fore Cyan "`nLIST OF STOREFRONT SERVERS:"
$StoreFrontIP
Write-Host -fore Cyan "`nLIST OF VDI SERVERS:"
$servers

##########################
# All VARIABLES CONFIGURED
########################## 
Write-Host -fore Cyan "`nCOMPLETED SANITY CHECK ON VARIABLES AND FILES"

######################################################
# Load Log File with Variables and Standard Parameters
######################################################
add-content -path $logfile -Value "`nLIST OF VARIABLES AND VALUES"
add-content -path $logfile -Value "----------------------------"
add-content -path $logfile -Value "wait = $wait"
add-content -path $logfile -Value "LoadmasterIP = $LoadmasterIP"
add-content -path $logfile -Value "LoadMasterPort = $LoadMasterPort"
add-content -path $logfile -Value "VirtualServiceIp = $VirtualServiceIp"
add-content -path $logfile -Value "Use_HTML5 = $Use_HTML5"
add-content -path $logfile -Value "`n#### RADIUS AND LDAP SETTINGS ####"
add-content -path $logfile -Value "Use_Ldap = $Use_Ldap"
add-content -path $logfile -Value "Use_Radius = $Use_Radius"
add-content -path $logfile -Value "AuthServers = $AuthServers"
add-content -path $logfile -Value "AuthUser = $ServiceAccount"
add-content -path $logfile -Value "AuthPass = #####"
add-content -path $logfile -Value "Domain = $Domain"
add-content -path $logfile -Value "SharedSecret = #####"
add-content -path $logfile -Value "`n#### CITRIX STOREFRONT SETTINGS ####"
add-content -path $logfile -Value "StorePath = $StorePath"
add-content -path $logfile -Value "FQDN = $ExternalURL"
add-content -path $logfile -Value "CertName = $CertName"
add-content -path $logfile -Value "CertFile = $CertFile"
add-content -path $logfile -Value "CertPass = #####"
add-content -path $logfile -Value "CA_Name = $CA_Name"
add-content -path $logfile -Value "CA_File = $CA_File"
add-content -path $logfile -Value "`n#### STOREFRONT SERVER LIST ####"
add-content -path $logfile -Value "RA_Name = $RA_Name"
add-content -path $logfile -Value "RA_File = $RA_File"
add-content -path $logfile -Value $StoreFrontIp
add-content -path $logfile -Value "`n#### VDI SERVER LIST ####"
add-content -path $logfile -Value $servers
add-content -path $logfile -Value "`n#### STANDARD VIRTUAL SERVICE PARAMETERS####"
add-content -path $logfile -Value "VirtualServiceName = $VSName"
add-content -path $logfile -Value "VirtualServicePort = $VSPort"
add-content -path $logfile -Value "RealServerPort = $RSPort"
add-content -path $logfile -Value "`n#### COMMON VDI PARAMETERS ####"
add-content -path $logfile -Value "starting_index = $starting_index"
add-content -path $logfile -Value "starting_port = $starting_port"
add-content -path $logfile -Value "`n#### STANDARD VDI 2598 PARAMETERS ####"
add-content -path $logfile -Value "vdi2589_vs_name = $vdi2589_vs_name"
add-content -path $logfile -Value "vdi2589_RS_Port = $vdi2589_RS_Port"
add-content -path $logfile -Value "`n#### Standard VDI HTML5 VS Parameters"
add-content -path $logfile -Value "vdi8008_vs_name = $vdi8008_vs_name"
add-content -path $logfile -Value "vdi8008_RS_Port = $vdi8008_RS_Port"
add-content -path $logfile -Value "############# END OF PARAMETERS ###########"



write-host -fore Cyan "`nPREPARING LOADMASTER FOR CITRIX"

#################################
# Install StoreFront Certificates
#################################

$CertPass = Read-Host "Please Enter pfx cert password"  ## UPDATE - Will be promted for Password

if (-NOT $doCert) {
  add-content -path $logfile -Value "Skipping certificate install, $certname already exists."
  write-host "TLS certificate named $CertName already installed. Skipping TLS certificate install"
  } 
  else {
  if (Test-Path $certfile) {
  Write-Host "Installing TLS certificate from $certfile"
  add-content -path $logfile -Value "`n#### Installing TLS certificate from $certfile"
  $catch = New-TlsCertificate -Name $CertName -Password $CertPass -Path $CertFile
  add-content -path $logfile -Value "$catch"
  $catch = start-sleep -milliseconds $wait
  $catch = start-sleep -milliseconds $wait  
  }
}

if (-NOT $doCA) {
  add-content -path $logfile -Value "Skipping intermediate certificate install - $CA_File"
  }
  else {
  if (Test-Path $CA_File) {
  Write-Host "Installing intermediate certificate from $CA_File"
  add-content -path $logfile -Value "`n#### Installing intermediate certificate from $CA_File"
  $catch = New-TlsIntermediateCertificate -Name $CA_Name -Path $CA_File
  add-content -path $logfile -Value "$catch"
  $catch = start-sleep -milliseconds $wait
  $catch = start-sleep -milliseconds $wait
  }
}

if (-NOT $doRA) {
  add-content -path $logfile -Value "Skipping root certificate install - $RA_File"
  }
  else {
  if (Test-Path $RA_File) {
  Write-Host "Installing root certificate from $RA_File"
  add-content -path $logfile -Value "`n#### Installing root certificate from $RA_File"
  $catch = New-TlsIntermediateCertificate -Name $RA_Name -Path $RA_File
  add-content -path $logfile -Value "$catch"
  $catch = start-sleep -milliseconds $wait
  $catch = start-sleep -milliseconds $wait
  }
}

############################
# Global LoadMaster Settings                                                          
############################
Write-Host "Setting Global LoadMaster Parameters"
write-host -fore Cyan "Please Wait to enter Radius or LDAP Test Account Password"
add-content -path $logfile -Value "## Enable Share SubVS Persistence"
$catch = Set-AdcL7Configuration -ShareSubVSPersistance 1
add-content -path $logfile -Value "$catch"



################################
#Create Radius MFA Configuration 
################################
if ($Use_Radius) {


$TestAccountPass = Read-Host -Prompt  'Please Enter Password for Radius Auth Server Test Account' -AsSecureString  ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (Password for $ServiceAccount)
$RadiusSharedSecret = Read-Host -Prompt  'Enter Radius Shared Secret' -AsSecureString ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (Radius shared secret)

add-content -path $logfile -Value "`n#### Create Radius MFA Configuration ####"
Write-Host "Creating new RADIUS client side SSO domain"
$catch = New-SSODomain -Domain $Domain
add-content -path $logfile -Value "$catch"
$catch = Set-SSODomain -Domain $Domain -logon_domain $Domain -auth_type RADIUS -Server $AuthServers -radius_shared_secret $RadiusSharedSecret -logon_fmt Principalname -sess_tout_idle_pub 1800 -sess_tout_idle_priv 1800 -testuser $TestAccount -testpass $TestAccountPass
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}


################################
# Create LDAP Configuration 
################################
if ($Use_LDAP) {

$TestAccountPass = Read-Host -Prompt  'Please Enter Password for LDAP Auth Server Test Account' -AsSecureString  ## UPDATE - Modify if $Use_LDAP or $Use_Radius is $True. (Password for $ServiceAccount)

add-content -path $logfile -Value "`n#### Create LDAPS MFA Configuration ####"
Write-Host "Creating new LDAP endpoint"
$catch = New-LdapEndpoint -Name $Domain -AdminPass $TestAccountPass -AdminUser $TestAccount -LdapProtocol LDAPS -Server $AuthServers
add-content -path $logfile -Value "$catch"
Write-Host "Creating new LDAP client side SSO domain"
$catch = New-SSODomain -Domain $Domain
add-content -path $logfile -Value "$catch"
$catch = Set-SSODomain -Domain $Domain -logon_domain $Domain -ldap_endpoint $Domain -tls ldaps -auth_type ldap-ldaps -logon_fmt Principalname -sess_tout_idle_pub 1800 -sess_tout_idle_priv 1800 -ldapephc 1
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}


###############################
# Create Content Matching Rules
###############################
Add-Content -Path $logfile -Value "`n#### Create Content Matching Rules ####"
Write-Host -fore cyan "`nCREATING CONTENT MATCHING RULES"
Write-Host "Citrix_Auth"
$catch = New-AdcContentRule -RuleName "Citrix_Auth" -MatchType regex -NoCase $true -Pattern "/^\/Citrix\/.*Auth\/.*|^\/Citrix\/.*\/CitrixAuth\/Login.*|\/Citrix\/.*\/ExplicitAuth\/AllowSelfServiceAccountManagement.*|\/Citrix\/.*\/Resources\/List.*/"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_Auth_Cookie"
$catch = New-AdcContentRule -RuleName "Citrix_Auth_Cookie" -MatchType regex -Header Cookie -Pattern "CtxsAuthId" -NoCase $true -OnlyOnFlag 2
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_LMDATA_Cookie"
$catch = New-AdcContentRule -RuleName "Citrix_LMDATA_Cookie" -MatchType regex -Header Cookie -Pattern "lmdata" -NoCase $true -SetFlagOnMatch 2
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_LM_Auth_Proxy"
$catch = New-AdcContentRule -RuleName "Citrix_LM_Auth_Proxy"-MatchType regex -NoCase $true -Pattern "/^\/lm_auth_proxy.*/"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_Logout"
$catch = New-AdcContentRule -RuleName "Citrix_Logout" -MatchType regex -Pattern "/^\/Citrix\/.*\/Authentication\/Logoff.*/" -NoCase $true -SetFlagOnMatch 3
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_Receiver_Useragent"
$catch = New-AdcContentRule -RuleName "Citrix_Receiver_Useragent" -MatchType regex -Header User-Agent -Pattern "/^CitrixReceiver.*|CitrixWorkspace.*/"-NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_Useragent_Desktop_Receiver"
$catch = New-AdcContentRule -RuleName "Citrix_Useragent_Desktop_Receiver" -MatchType regex -Header User-Agent -Pattern "/^CitrixReceiver.*SelfService.*|SelfService.*/"-NoCase $true -Negate $true -SetFlagOnMatch 2
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_Download_ICA_File"
$catch = New-AdcContentRule -RuleName "Citrix_Download_ICA_File" -MatchType regex -IncQuery $True -Pattern /^\/Citrix\/.*Web\/Resources\/LaunchIca\/.*CsrfToken.*/ -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_WorkSpace_Receiver_PreAuth"
$catch = New-AdcContentRule -RuleName "Citrix_WorkSpace_Receiver_PreAuth" -MatchType regex -IncQuery $True -Pattern /^\/Citrix\/kempstoreAuth\/ExplicitForms$/ -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_PNAgent_Store"
$catch = New-AdcContentRule -RuleName "Citrix_PNAgent_Store" -MatchType regex -Pattern "/^\/citrix\/$store\/pnagent.*/" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_PNAgent_LaunchApp"
$catch = New-AdcContentRule -RuleName "Citrix_PNAgent_LaunchApp" -MatchType regex -Pattern "/^\/citrix\/store\/pnagent\/launch.aspx$/" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

##################################
# Create Header Modification Rules
##################################
add-content -path $logfile -Value "`n#### Create Header Modification Rules ####"
write-host -fore cyan "`nCREATING HEADER MODIFICATION RULES"

write-host "Citrix_AcceptEncoding"
$catch = New-AdcContentRule -RuleName Citrix_AcceptEncoding -Type 2 -Pattern Accept-Encoding
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_Browser_URL"
$catch = New-AdcContentRule -RuleName Citrix_Browser_URL -Type 4 -Pattern /^\/$/ -Replacement $StorePath
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_Delete_CtxAithID"
$catch = New-AdcContentRule -RuleName Citrix_Delete_CtxAithID -Type 1 -Header Set-Cookie -Replacement "CtxsAuthId=*; expires=Thu, 14-Jun-1990 16:53:03 GMT; path=$StorePath/; secure" -OnlyOnFlag 3
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_HTTPS"
$catch = New-AdcContentRule -RuleName Citrix_HTTPS -Type 1 -Header X-Citrix-IsUsingHTTPS -Replacement Yes
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_HTTP_200_To_302"
$catch = New-AdcContentRule -RuleName Citrix_HTTP_200_To_302 -Type 4 -Pattern "200 OK" -Replacement "301 Moved Permanently"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_Redirect"
$catch = New-AdcContentRule -RuleName Citrix_Redirect -Type 1 -Header Location -Replacement "https://$FQDN$StorePath/"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

write-host "Citrix_Delete_DeviceID"
$catch = New-AdcContentRule -RuleName Citrix_Delete_DeviceID -Type 3 -Header Cookie -Pattern "/^CtxsDeviceId=.*\; (.*)\; (.*)/" -Replacement "\1; \2"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

################################
# Create Body Modification Rules
################################
add-content -path $logfile -Value "`n#### Create Body Modification Rules ####"
Write-Host -fore cyan "`nCREATING BODY MODIFICATION RULES"


Write-Host "Citrix_GatewayAddress"
$catch = New-AdcContentRule -RuleName Citrix_GatewayAddress -Type 5 -Pattern "LongCommandLine="  -Replacement "Address=$FQDN" -OnlyOnFlag 2 -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


Write-Host "Citrix_SSL_On"
$catch = New-AdcContentRule -RuleName Citrix_SSL_On -Type 5 -Pattern "SSLEnable=Off" -Replacement "SSLEnable=On" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


Write-Host "Citrix_UDPCGP"
$catch = New-AdcContentRule -RuleName  Citrix_UDPCGP -Type 5 -Pattern "/UDPCGPPort=.*:2598/" -Replacement "UDPCGPPort=$FQDN:2598" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


Write-Host "Citrix_UDPICA"
$catch = New-AdcContentRule -RuleName  Citrix_UDPICA -Type 5 -Pattern "/UDPICAPort=.*:1494/" -Replacement "UDPICAPort=$FQDN:1494" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

Write-Host "Citrix_UDPWebSocket"
$catch = New-AdcContentRule -RuleName  Citrix_UDPWebSocket -Type 5 -Pattern "/UDPWebSocketPort=.*:8008/" -Replacement "UDPWebSocketPort=$FQDN:8008" -NoCase $true
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait



write-host -fore cyan "`nALL RULES CREATED"


#############################
# Creating Virtual Services #
#############################
Write-Host -fore cyan "`nCREATING VIRTUAL SERVICES"

######################################################
#Create VS - Citrix StoreFront Gateway - HTTP redirect
######################################################
add-content -path $logfile -Value "`n#### Create VS - Citrix StoreFront Gateway - HTTP redirect ####"
Write-Host -fore cyan "`nCREATING VIRTUAL SERVICE = Citrix Storefront Gateway - HTTP redirect"

$catch = (New-AdcVirtualService -VirtualService $VirtualServiceIp -nickname "Citrix StoreFront Gateway - HTTP redirect" -VSPort 80 -VSProtocol tcp -VSType http )
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

$catch = Set-AdcVirtualService -VirtualService $VirtualServiceIp -VSPort 80 -VSProtocol tcp -ErrorCode 302 -ErrorUrl https://%h%s -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

######################################
# Create VS - Citrix StoreFront Gateway
######################################
add-content -path $logfile -Value "`n#### Create VS - Citrix StoreFront Gateway ####"
write-host -fore cyan "`nCREATING VIRTUAL SERVICE = Citrix StoreFront Gateway"

$VS = (New-AdcVirtualService -VirtualService $VirtualServiceIp -nickname $VSName -VSPort $VSPort -VSProtocol tcp -VSType http -SSLAcceleration $true -SSLReencrypt $true -CertFile $CertName)
add-content -path $logfile -Value "$VS"
$VSIndex = $VS.data.VS.Index
$catch = start-sleep -milliseconds $wait

add-content -path $logfile -Value "## Add Rules to VS - Citrix StoreFront Gateway"

#############################
# Assign HTTP Selection Rules 

if ($USE_ESP) {
# Citrix_Logout
$catch = New-AdcVirtualServiceRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RuleType pre -RuleName Citrix_Logout
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_LMDATA_Cookie
$catch = New-AdcVirtualServiceRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RuleType pre -RuleName Citrix_LMDATA_Cookie
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}

##################################
# Assign HTTP Header Modifications

# Citrix_Browser_URL
$catch = New-AdcVirtualServiceRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RuleType request -RuleName Citrix_Browser_URL
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

if ($Use_ESP) {
# Citrix_Delete_CtxAithID
$catch = New-AdcVirtualServiceRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RuleType response -RuleName Citrix_Delete_CtxAithID
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
} 

#############################
# Create Sub Virtual Services
#############################
add-content -path $logfile -Value "`n#### Create Sub Virtual Services ####"


if ($Use_ESP) {
##################################
#SubVS StoreFront Browser Auth ESP
##################################
add-content -path $logfile -Value "`n#### SubVS StoreFront Browser Auth ESP ####"
Write-Host "Creating sub virtual service = StoreFront Browser Auth ESP"

$StoreFrontBrowserAuthESP = (New-AdcSubVirtualService -VSIndex $VSIndex)
$StoreFrontBrowserAuthESPIndex = ($StoreFrontBrowserAuthESP.Data.VS.SubVS[-1]).VSIndex
$StoreFrontBrowserAuthESPIndexRS = $StoreFrontBrowserAuthESP.Data.VS.SubVS.RSIndex

$catch = Set-AdcSubVirtualService -SubVSIndex $StoreFrontBrowserAuthESPIndex -Persist cookie-src -cookie "CtxsAuthId" -PersistTimeout 3600 -CheckPort $RSPort -CheckType https -CheckUrl $StorePath -CheckUse1_1 1 -Nickname "StoreFront Browser Auth ESP" -VSType http -Weight 1000 -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

############
# Enable ESP
add-content -path $logfile -Value "## Enable ESP"

$catch = Set-AdcSubVirtualService  -SubVSIndex $StoreFrontBrowserAuthESPIndex -ESPEnabled $true -InputAuthMode 2 -AllowedHosts $FQDN -AllowedDirectories "/*" -OutputAuthMode 2
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

$catch = Set-AdcSubVirtualService  -SubVSIndex $StoreFrontBrowserAuthESPIndex -Domain $Domain -ServerFbaPath "$StorePath/PostCredentialsAuth/Login" -Logoff $StorePath/Authentication/Logoff
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

#################################
# Add a Real Server to the SubVS
add-content -path $logfile -Value "## Add Real Servers"

for ($i=0; $i -lt $StoreFrontIP.Count; $i++) {
 $ip = $StoreFrontIP[$i]
 add-content -path $logfile -Value "  Adding $ip"
 write-host "   Adding StoreFront Server $ip"
 $catch = New-AdcRealServer -VSIndex $StoreFrontBrowserAuthESPIndex -RealServer $ip -RealServerPort $RSPort -Enable $true -Forward nat -Weight 1000 -Non_Local $true
 add-content -path $logfile -Value "$catch"
 $catch = start-sleep -milliseconds $wait
 }
 
add-content -path $logfile -Value "## Assigning Rules"


########################################
# Assign HTTP Header Modifications Rules

# Citrix_HTTPS
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserAuthESPIndex -RuleType request -RuleName Citrix_HTTPS
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_AcceptEncoding
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserAuthESPIndex -RuleType request -RuleName Citrix_AcceptEncoding
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_HTTP_200_To_302
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserAuthESPIndex -RuleType response -RuleName Citrix_HTTP_200_To_302
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Redirect
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserAuthESPIndex -RuleType response -RuleName Citrix_Redirect
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}

###########################################
# SubVS StoreFront Browser Launch HTML5 App
###########################################
if ($Use_HTML5) {
add-content -path $logfile -Value "`n#### SubVS StoreFront Browser Launch App ####"
Write-Host "Creating sub virtual service = StoreFront Browser Launch HTML5 App"

$StoreFrontBrowserLaunchHTML5App = (New-AdcSubVirtualService -VSIndex $VSIndex)
$StoreFrontBrowserLaunchHTML5AppIndex =   ($StoreFrontBrowserLaunchHTML5App.Data.VS.SubVS[-1]).VSIndex
$StoreFrontBrowserLaunchHTML5AppIndexRS = ($StoreFrontBrowserLaunchHTML5App.Data.VS.SubVS[-1]).RSIndex
 
$catch = Set-AdcSubVirtualService -SubVSIndex $StoreFrontBrowserLaunchHTML5AppIndex -Persist cookie-src -cookie "CtxsAuthId" -PersistTimeout 3600 -CheckPort $RSPort -CheckType https -CheckUrl $StorePath -CheckUse1_1 1 -Nickname "StoreFront Browser Launch HTML5 App" -VSType http -Weight 1000 -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

add-content -path $logfile -Value "## Add Real Servers"
####################
# Add a Real Servers
for ($i=0; $i -lt $StoreFrontIP.Count; $i++) {
 $ip = $StoreFrontIP[$i]
 add-content -path $logfile -Value "  Adding $ip"
 write-host "   Adding StoreFront Server $ip"
 $catch = New-AdcRealServer -VSIndex $StoreFrontBrowserLaunchHTML5AppIndex -RealServer $ip -RealServerPort $RSPort -Enable $true -Forward nat -Weight 1000 -Non_Local $true
 add-content -path $logfile -Value "$catch"
 $catch = start-sleep -milliseconds $wait
}
 
add-content -path $logfile -Value "## Assigning Rules"


#############################
# Assign HTTP Selection Rules

# Citrix_Useragent_Desktop_Receiver
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserLaunchHTML5AppIndex -RuleType pre -RuleName Citrix_Useragent_Desktop_Receiver
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

########################################
# Assign HTTP Header Modifications Rules

# Citrix_AcceptEncoding
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontBrowserLaunchHTML5AppIndex -RuleType request -RuleName Citrix_AcceptEncoding
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

#########################################
# Assign Response Body Modification Rules


}

 
################################################
#SubVS StoreFront Workspace-Receiver Add Account
################################################
add-content -path $logfile -Value "`n#### SubVS StoreFront Workspace-Receiver Add Account ####"
Write-Host "Creating sub virtual service = StoreFront Workspace Receiver Add Account"

$StoreFrontWorkspaceReceiverAddAccount = (New-AdcSubVirtualService -VSIndex $VSIndex)
$StoreFrontWorkspaceReceiverAddAccountIndex = ($StoreFrontWorkspaceReceiverAddAccount.Data.VS.SubVS[-1]).VSIndex
$StoreFrontWorkspaceReceiverAddAccountIndexRS = ($StoreFrontWorkspaceReceiverAddAccount.Data.VS.SubVS[-1]).RSIndex
 
$catch = start-sleep -milliseconds $wait
$catch = Set-AdcSubVirtualService -SubVSIndex $StoreFrontWorkspaceReceiverAddAccountIndex -Persist cookie-src -cookie "CtxsAuthId" -PersistTimeout 3600 -CheckPort $RSPort -CheckType https -CheckUrl $StorePath -CheckUse1_1 1 -Nickname "StoreFront Workspace-Receiver Add Account" -VSType http -Weight 1000 -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
 
####################
# Add a Real Servers
for ($i=0; $i -lt $StoreFrontIP.Count; $i++) {
 $ip = $StoreFrontIP[$i]
 add-content -path $logfile -Value "  Adding $ip"
 write-host "   Adding StoreFront Server $ip"
 $catch = New-AdcRealServer -VSIndex $StoreFrontWorkspaceReceiverAddAccountIndex -RealServer $ip -RealServerPort $RSPort -Enable $true -Forward nat -Weight 1000 -Non_Local $true
 add-content -path $logfile -Value "$catch"
 $catch = start-sleep -milliseconds $wait
}

add-content -path $logfile -Value "## Assigning Rules"
#############################
# Add Content Matching Rules



####################################
# Add HTTP Header Modification Rules

# Citrix_Delete_DeviceID
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontWorkspaceReceiverAddAccountIndex -RuleType request -RuleName Citrix_Delete_DeviceID
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


################################################
# SubVS StoreFront Workspace-Receiver Launch App
################################################
add-content -path $logfile -Value "`n#### SubVS StoreFront Workspace-Receiver Launch App ####"
Write-Host "Creating sub virtual service = StoreFront Workspace Receiver Launch App"

$StoreFrontWorkspaceReceiverLaunchApp = (New-AdcSubVirtualService -VSIndex $VSIndex)
$StoreFrontWorkspaceReceiverLaunchAppIndex = ($StoreFrontWorkspaceReceiverLaunchApp.Data.VS.SubVS[-1]).VSIndex
$StoreFrontWorkspaceReceiverLaunchAppRS = ($StoreFrontWorkspaceReceiverLaunchApp.Data.VS.SubVS[-1]).RSIndex
 
$catch = Set-AdcSubVirtualService -SubVSIndex $StoreFrontWorkspaceReceiverLaunchAppIndex -Persist cookie-src -cookie "CtxsAuthId" -PersistTimeout 3600 -CheckPort $RSPort -CheckType https -CheckUrl $StorePath -CheckUse1_1 1 -Nickname "StoreFront Workspace-Receiver Launch App" -VSType http -Weight 1000 -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

add-content -path $logfile -Value "## Add Real Servers"
####################
# Add a Real Servers
for ($i=0; $i -lt $StoreFrontIP.Count; $i++) {
 $ip = $StoreFrontIP[$i]
 add-content -path $logfile -Value "  Adding $ip"
 write-host "   Adding StoreFront Server $ip"
 $catch = New-AdcRealServer -VSIndex $StoreFrontWorkspaceReceiverLaunchAppIndex -RealServer $ip -RealServerPort $RSPort -Enable $true -Forward nat -Weight 1000 -Non_Local $true
 add-content -path $logfile -Value "$catch"
 $catch = start-sleep -milliseconds $wait
}

add-content -path $logfile -Value "## Assigning Rules"

#############################
## Add Content Matching Rules

################################
# HTTP Header Modification Rules
#
# Citrix_Useragent_Desktop_Receiver
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontWorkspaceReceiverLaunchAppIndex -RuleType pre -RuleName Citrix_Useragent_Desktop_Receiver
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
#
# Citrix_AcceptEncoding
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontWorkspaceReceiverLaunchAppIndex -RuleType request -RuleName Citrix_AcceptEncoding
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


##########################################################################################
# Response Body Modification Rules will be added in the VDI 2598 Listener Virtual Services


if ($Use_ESP) {
#######################################################
#SubVS StoreFront Workspace-Receiver Pre-Authentication
#######################################################
add-content -path $logfile -Value "`n#### SubVS StoreFront Workspace-Receiver Add Account ####"
Write-Host "Creating sub virtual service = StoreFront Workspace Receiver Add Account"

$StoreFrontWorkspaceReceiverPreAuthentication = (New-AdcSubVirtualService -VSIndex $VSIndex)
$StoreFrontWorkspaceReceiverPreAuthenticationIndex = ($StoreFrontWorkspaceReceiverPreAuthentication.Data.VS.SubVS[-1]).VSIndex
$StoreFrontWorkspaceReceiverPreAuthenticationIndexRS = ($StoreFrontWorkspaceReceiverPreAuthentication.Data.VS.SubVS[-1]).RSIndex
 
$catch = Set-AdcSubVirtualService -SubVSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndex -Persist cookie-src -cookie "CtxsAuthId" -PersistTimeout 3600 -CheckPort $RSPort -CheckType https -CheckUrl $StorePath -CheckUse1_1 1 -Nickname "StoreFront Workspace-Receiver Pre-Authentication" -VSType http -Weight 1000 -AddVia 5
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


###############
#Set ESP

add-content -path $logfile -Value "## Enable ESP"

$catch = Set-AdcSubVirtualService  -SubVSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndex -ESPEnabled $true -InputAuthMode 7 -AllowedHosts $FQDN -AllowedDirectories "/*" -OutputAuthMode 2
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

$catch = Set-AdcSubVirtualService  -SubVSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndex -Domain $Domain -ServerFbaPath "$StorePath/ExplicitAuth/Login"
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
 
####################
# Add a Real Servers
for ($i=0; $i -lt $StoreFrontIP.Count; $i++) {
 $ip = $StoreFrontIP[$i]
 add-content -path $logfile -Value "  Adding $ip"
 write-host "   Adding StoreFront Server $ip"
 $catch = New-AdcRealServer -VSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndex -RealServer $ip -RealServerPort $RSPort -Enable $true -Forward nat -Weight 1000 -Non_Local $true
 add-content -path $logfile -Value "$catch"
 $catch = start-sleep -milliseconds $wait
}

add-content -path $logfile -Value "## Assigning Rules"


####################################
# Add HTTP Header Modification Rules

# Citrix_Delete_DeviceID
$catch = New-AdcVirtualServiceRule -VSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndex -RuleType request -RuleName Citrix_Delete_DeviceID
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}

########################
# Content matching rules
########################
write-host "Adding content matching rules"
#################################################################################################

if ($Use_ESP) {

if ($Use_HTML5) {

# Citrix_PNAgent_Store
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_PNAgent_Store
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix__PNAgent_LaunchApp
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_PNAgent_LaunchApp
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_WorkSpace_Receiver_PreAuth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndexRS -RuleName Citrix_WorkSpace_Receiver_PreAuth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Download_ICA_File
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Download_ICA_File
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_LM_Auth_Proxy
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName Citrix_LM_Auth_Proxy
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Logout
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName Citrix_Logout
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Auth_Cookie
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserLaunchHTML5AppIndexRS -RuleName Citrix_Auth_Cookie
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Auth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_Auth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Receiver_Useragent
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Receiver_Useragent
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# default
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName default
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}

#################################################################################################

if (-NOT $Use_HTML5) {


# Citrix_PNAgent_Store
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_PNAgent_Store
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix__PNAgent_LaunchApp
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_PNAgent_LaunchApp
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Download_ICA_File
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Download_ICA_File
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_WorkSpace_Receiver_PreAuth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverPreAuthenticationIndexRS -RuleName Citrix_WorkSpace_Receiver_PreAuth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_LM_Auth_Proxy
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName Citrix_LM_Auth_Proxy
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Logout
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName Citrix_Logout
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

## Citrix_Auth_Cookie
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Auth_Cookie
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Auth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_Auth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Receiver_Useragent
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Receiver_Useragent
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# default
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserAuthESPIndexRS -RuleName default
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

}

}

#################################################################################################

if (-NOT $Use_ESP) {

if ($Use_HTML5) {

# Citrix_PNAgent_Store
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_PNAgent_Store
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix__PNAgent_LaunchApp
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_PNAgent_LaunchApp
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Download_ICA_File
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Download_ICA_File
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

## Citrix_Auth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_Auth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_Receiver_Useragent
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName Citrix_Receiver_Useragent
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


# default
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontBrowserLaunchHTML5AppIndexRS  -RuleName default
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}
ELSE {

## Citrix_Auth
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverAddAccountIndexRS -RuleName Citrix_Auth
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# default
$catch = New-AdcRealServerRule -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp -RSIndex $StoreFrontWorkspaceReceiverLaunchAppRS -RuleName default
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

}


}

#################################################################################################

add-content -path $logfile -Value "`nSUB-VIRTUAL SERVICES CREATED AND RULES ASSIGNED"

########################################################################
# Completed configuration of Citrix StoreFront Gateway Virtual Service #
########################################################################


##################################
# Create VDI 2598 Secure Listeners
##################################
add-content -path $logfile -Value "`n#### Create VDI 2598 Secure Listeners ####"
Write-Host -fore cyan "`nCREATING VIRTUAL SERVICES = VDI Secure Listeners"

$citrix_starting_index = $starting_index 
$citrix_vs_starting_port = $starting_port

$VS = (Get-AdcVirtualService -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp)

if ($Use_ESP) {
$SubVSIndex = ($VS.Data.VS.SubVS[-2]).VSIndex
}
ELSE {
$SubVSIndex = ($VS.Data.VS.SubVS[-1]).VSIndex
}

for ($i=0; $i -lt $servers.Count; $i++)
{
$index = $citrix_starting_index + $i
$RuleName = $vdi2589_vs_name + $index
$Port = $citrix_vs_starting_port + $i 
$Pattern = "Address=" + $servers[$i] + ":1494"
$Replacement = "SSLProxyHost=" + $FQDN + ":" + $Port
$ip = $servers[$i]

### Create new VS Secure Listeners
add-content -path $logfile -Value "## Create VDI 2598 Secure Listener"
Write-Host "Creating VDI 2598 Secure Listener $IP"
$catch = (New-AdcVirtualService -VirtualService $VirtualServiceIp -nickname $RuleName -VSPort $Port -VSProtocol tcp -VSType http -SSLAcceleration $true -SSLReencrypt $false -CertFile $CertName -CheckType none -AddVia 5)
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
$catch = (Set-AdcVirtualService -VirtualService $VirtualServiceIp  -VSPort $Port -VSProtocol tcp -VSType gen )
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


### Add Real Server to VS
add-content -path $logfile -Value "  Adding VDI Server $ip"
$catch = New-AdcRealServer -RealServer $ip -RealServerPort $vdi2589_RS_Port -Non_Local 1 -Enable $true -Forward nat -Weight 1000 -VirtualService $VirtualServiceIp -VSPort $Port -VSProtocol tcp    
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

### Create new ICA Rewrite Rules
add-content -path $logfile -Value "##  Create new ICA Rewrite Rule"
$catch = New-AdcContentRule -RuleName $RuleName -Type 5 -Pattern $Pattern -Replacement $Replacement -NoCase 1
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

##################################
# Response Body Modification Rules
add-content -path $logfile -Value "##  Assigning new ICA Rewrite Rule"
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName $RuleName
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait
}

##################################
# Response Body Modification Rules

# Citrix_GatewayAddress
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_GatewayAddress
add-content -path $logfile -Value "$catch"

# Citrix_SSL_On
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_SSL_On
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait


# Citrix_UDPCGP
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPCGP
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_UDPICA
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPICA
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_UDPWebSocket
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPWebSocket
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait



if ($Use_HTML5) {
########################################
# Create VDI HTML5 8008 Secure Listeners
########################################
add-content -path $logfile -Value "`n##### # Create VDI HTML5 8008 Secure Listeners #####"
Write-Host -fore cyan "`nCREATING VIRTUAL SERVICES = HTML5 VDI Secure Listeners"

$citrix_starting_index = $starting_index
$citrix_vs_starting_port = $port + 1

$VS = (Get-AdcVirtualService -VirtualService $VirtualServiceIp -VSPort $VSPort -VSProtocol tcp)

if ($Use_ESP) {
$SubVSIndex = ($VS.Data.VS.SubVS[-4]).VSIndex
}
ELSE {
$SubVSIndex = ($VS.Data.VS.SubVS[-3]).VSIndex
}


    for ($i=0; $i -lt $servers.Count; $i++)
    {

    $RuleName = $vdi8008_vs_name + ($citrix_starting_index + $i)
    $Port = $citrix_vs_starting_port + $i 
    $Pattern = "Address=" + $servers[$i] + ":1494"
    $Replacement = "SSLProxyHost=" + $ExternalURL + ":" + $Port
    $ip = $servers[$i]

    ### Create new VS Secure Listeners
    add-content -path $logfile -Value "## Create new VS Secure Listeners"
    Write-Host "Creating VDI HTML5 8008 Secure Listener $IP"
    $catch = (New-AdcVirtualService -VirtualService $VirtualServiceIp -nickname $RuleName -VSPort $Port -VSProtocol tcp -VSType gen -SSLAcceleration $true -SSLReencrypt $false -CertFile $CertName -CheckType none -AddVia 5)
    add-content -path $logfile -Value "$catch"
    $catch = start-sleep -milliseconds $wait

    ### Add Real Server to VS
    add-content -path $logfile -Value "  Adding VDI Server $ip"
    $catch = New-AdcRealServer -RealServer $ip -RealServerPort $vdi8008_RS_Port -Non_Local 1 -Enable $true -Forward nat -Weight 1000 -VirtualService $VirtualServiceIp -VSPort $Port -VSProtocol tcp
    add-content -path $logfile -Value "$catch"
    $catch = start-sleep -milliseconds $wait
    
    ### Create new ICA Rewrite Rules
    add-content -path $logfile -Value "## Create ICA Rule"
    $catch = New-AdcContentRule -RuleName $RuleName -Type 5 -Pattern $Pattern -Replacement $Replacement -NoCase 1
    add-content -path $logfile -Value "$catch"
    $catch = start-sleep -milliseconds $wait

    ##################################
    # Response Body Modification Rules 
    add-content -path $logfile -Value "## Assign ICA Rule"
    $catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName $RuleName
    add-content -path $logfile -Value "$catch"
    $catch = start-sleep -milliseconds $wait
    }

##################################
# Response Body Modification Rules

# Citrix_GatewayAddress
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_GatewayAddress
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_SSL_On
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_SSL_On
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_UDPCGP
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPCGP
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_UDPICA
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPICA
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait

# Citrix_UDPWebSocket
$catch = New-AdcVirtualServiceResponseBodyRule -VSIndex $SubVSIndex -RuleName Citrix_UDPWebSocket
add-content -path $logfile -Value "$catch"
$catch = start-sleep -milliseconds $wait



}
   
if ($Use_HTML5 -AND $Use_LDAP) { 
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING HTML5 AND ESP (LDAPS) COMPLETED"
write-host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING HTML5 AND ESP (LDAPS) COMPLETED" 
}

if ($Use_HTML5 -AND $Use_Radius) {
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING HTML5 AND ESP (RADIUS) COMPLETED"
Write-Host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING HTML5 AND ESP (RADIUS) COMPLETED" 
}

if ((-NOT $Use_HTML5) -AND $Use_LDAP) {
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING ICA AND ESP (LDAPS) COMPLETED"
write-host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING ICA AND ESP (LDAPS) COMPLETED" 
}

if ((-NOT $Use_HTML5) -AND $Use_Radius) {
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING ICA AND ESP (RADIUS) COMPLETED"
write-host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING ICA AND ESP (RADIUS) COMPLETED" 
}

if ($Use_HTML5 -AND (-NOT $Use_ESP)) {
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING HTML5 WITHOUT ESP COMPLETED"
write-host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES COMPLETED" 
}

if ((-NOT $Use_HTML5) -AND (-NOT $Use_ESP)) {
add-content -path $logfile -Value "`nPROVISIONING OF CITRIX VIRTUAL SERVICES USING ICA WITHOUT ESP COMPLETED"
write-host -fore cyan "`nPROVISIONING OF CITRIX VIRTUAL SERVICES COMPLETED" 
}

# Warn user that a reboot is required to enable Sare SubVS Persistence Globally
write-host -fore DarkMagenta -BackgroundColor yellow "`nPLEASE REBOOT LOADMASTER TO COMPLETE CITRIX VIRTUAL SERVICE INSTALL`n"
pause

#################
# END OF SCRIPT #
#################


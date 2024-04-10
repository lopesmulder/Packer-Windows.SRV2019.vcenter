# vCenter credentials
# Use environment variables or pass with build command
# vcenter_username = "(Username!)"
# vcenter_password = "(Put your password Here!)"

# vCenter details
vcenter_server = ""
vcenter_sslconnection = true
vcenter_datacenter = ""
vcenter_cluster = ""
vcenter_datastore = ""
vcenter_folder = ""

# VM Hardware Configuration
vm_os_type = "windows9Server64Guest"
vm_firmware = "efi"
vm_hardware_version = 17
vm_cpu_sockets = 2
vm_cpu_cores = 1
vm_ram = 4096
vm_nic_type = "vmxnet3"
vm_network = "serviceVMNetwork"
vm_disk_controller = ["pvscsi"]
vm_disk_size = 20480
vm_disk_thin = true
config_parameters = {
        "devices.hotplug" = "FALSE",
        "guestInfo.svga.wddm.modeset" = "FALSE",
        "guestInfo.svga.wddm.modesetCCD" = "FALSE",
        "guestInfo.svga.wddm.modesetLegacySingle" = "FALSE",
        "guestInfo.svga.wddm.modesetLegacyMulti" = "FALSE"
}

# Removable Media Configuration
vcenter_iso_datastore = ""
os_iso_path = "ISO"
os_iso_file = "en-us_windows_server_2022_updated_march_2023_x64_dvd_dd2f76bb.iso"
vmtools_iso_path = "ISO/VMTools"
vmtools_iso_file = "windows.iso"
vm_cdrom_remove = true

# Build Settings
build_repo = "https://github.com/cwestwater/packer-vsphere-iso"
vm_convert_template = false
winrm_username = "(Username)"
# winrm_password = "(Put your password Here!)"

# Provisioner Settings
powershell_scripts = [
    "../scripts/win2019/config-os.ps1",
]

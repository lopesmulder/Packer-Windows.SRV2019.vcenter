packer {

    required_version = ">= 1.9.4"

    required_plugins {
        vsphere = {
            version = ">= v1.2.2"
            source = "github.com/hashicorp/vsphere"
        }
    }

}

source "vsphere-iso" "win2019std" {

    # vCenter Credentials

    username = var.vcenter_username
    password = var.vcenter_password

    # vCenter Details

    vcenter_server = var.vcenter_server
    insecure_connection = var.vcenter_sslconnection
    datacenter = var.vcenter_datacenter
    cluster = var.vcenter_cluster
    datastore = var.vcenter_datastore
    folder= var.vcenter_folder

    # VM Hardware Configuration

    vm_name ="win2019std"
    notes = "Version: ${ local.build_version }\nBuild Time: ${ local.build_date }\nSource: ${ var.build_repo }\nOS: Windows Server 2019 Standard"
    guest_os_type = var.vm_os_type
    firmware = var.vm_firmware
    vm_version = var.vm_hardware_version
    CPUs = var.vm_cpu_sockets
    cpu_cores = var.vm_cpu_cores
    RAM = var.vm_ram
    network_adapters {
        network_card = var.vm_nic_type
        network = var.vm_network
    }
    disk_controller_type = var.vm_disk_controller
    storage {
        disk_size = var.vm_disk_size
        disk_thin_provisioned = var.vm_disk_thin
    }
    configuration_parameters = var.config_parameters

    # Removable Media Configuration

    iso_paths = [
        "[${ var.vcenter_iso_datastore }] ${ var.os_iso_path }/${ var.os_iso_file }",
        "[${ var.vcenter_iso_datastore }] ${ var.vmtools_iso_path }/${ var.vmtools_iso_file }"
    ]

    floppy_files = [
        "../bootfiles/win2019/standard/autounattend.xml",
        "../scripts/common/install-vmtools64.cmd",
        "../scripts/common/initial-setup.ps1"
    ]

    remove_cdrom = var.vm_cdrom_remove
    convert_to_template = var.vm_convert_template

    # Build Settings

    boot_command = [
        "<spacebar>"
    ]
    boot_wait = "3s"

    ip_wait_timeout = "30m"
    communicator = "winrm"
    winrm_timeout = "8h"
    winrm_username = var.winrm_username
    winrm_password = var.winrm_password
    shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Build Complete\""
    shutdown_timeout = "1h"
}

build {
    name = "Windows Server 2019"
    sources = [
        "source.vsphere-iso.win2019std"
    ]

    provisioner "windows-restart" {}

    provisioner "powershell" {
        elevated_user = var.winrm_username
        elevated_password  = var.winrm_password
        scripts = var.powershell_scripts
    }

}

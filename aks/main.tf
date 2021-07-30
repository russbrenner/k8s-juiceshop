provider "azurerm" {
    features {}
}

terraform {
    ## Defining a backend allows to store the state file on an Azure Storage Account
    backend "azurerm" {
        storage_account_name = "cs41003200032bfb00a"
        container_name = "tfstate"
        key = "codelab.microsoft.tfstate"
        
        ## Leaving this field out allows to use ENV variable ARM_ACCESS_KEY instead as the Storage Account's Access Key
        # access_key = ""
    }
}

locals{
  clusters_name= ["MontrealCollegeCluster1","MontrealCollegeCluster2","MontrealCollegeCluster3","MontrealCollegeCluster4"]

} 
resource "azurerm_resource_group" "examoct2023" {
  name     = "MCITEXAM"
  location = "Central Canada"
}

resource "azurerm_kubernetes_cluster" "k8scluster" {
  for_each            ={for cluster in local.clusters_name:cluster=>cluster}
  name                = "MontrealCollege"
  location            = azurerm_resource_group.examoct2023.location
  resource_group_name = azurerm_resource_group.examoct2023.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = "00000000-0000-0000-0000-000000000000"
    client_secret = "00000000000000000000000000000000"
  }
}

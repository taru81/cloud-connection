#include "CloudConnectionPluginPCH.hpp"
#include "CloudConnectionModule.hpp"
#include "ClientFactory.hpp"

CloudConnectionModule CloudConnectionModule::g_GlobalManager; ///< static one global instance of our manager

/** RTTI definitions */
V_IMPLEMENT_DYNAMIC( CloudConnectionModule, VTypedObject, &g_CloudConnectionModule );

CloudConnectionModule::CloudConnectionModule()
{
  // creates a new cloud connection client for the target platform
  m_pCloudConnClient = ClientFactory::GetCloudConnectionClient(); 
}

CloudConnectionModule::~CloudConnectionModule()
{
  V_SAFE_DELETE( m_pCloudConnClient );
}

CloudConnectionClient* CloudConnectionModule::GetClient()
{
  return m_pCloudConnClient;
}

void CloudConnectionModule::OnHandleCallback(IVisCallbackDataObject_cl *pData)
{

}
using Atencion_Cliente.Models;
using System.Collections.Generic;

namespace Atencion_Cliente.ViewModels
{
    public class ClienteView
    {
        public ClienteModel cliente { get; set; }
        public List<ClienteModel> ClienteList { get; set; }
        public List<MotivoModel> MotivoList { get; set; }
        public string fecha { get; set; }
        public int respuesta { get; set; }
    }
}

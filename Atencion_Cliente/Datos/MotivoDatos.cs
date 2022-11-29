using Atencion_Cliente.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Atencion_Cliente.Datos
{
    public class MotivoDatos
    {
        public List<MotivoModel> Listar()
        {
            var oLista = new List<MotivoModel>();
            var cn = new Conexion();
            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("sp_motivo_sel", conexion);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new MotivoModel()
                        {
                            idMotivo = Convert.ToInt32(dr["idMotivo"]),
                            descMotivo = dr["descMotivo"].ToString(),
                        });
                    }
                }
                return oLista;
            }
        }
    }
}

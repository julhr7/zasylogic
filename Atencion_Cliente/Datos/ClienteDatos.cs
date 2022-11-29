using Atencion_Cliente.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Atencion_Cliente.Datos
{
    public class ClienteDatos
    {
        public List<ClienteModel> Listar(string fecha)
        {
            var oLista = new List<ClienteModel>();
            var cn = new Conexion();
            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("sp_cliente_sel", conexion);
                cmd.Parameters.AddWithValue("fecha", fecha);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oLista.Add(new ClienteModel(){
                            idAtencionCliente = Convert.ToInt32(dr["idAtencionCliente"]),
                            nombres = dr["nombres"].ToString(),
                            apellidos = dr["apellidos"].ToString(),
                            celular = dr["celular"].ToString(),
                            email = dr["email"].ToString(),
                            sexo = Convert.ToInt32(dr["sexo"].ToString()),
                            descSexo = dr["descSexo"].ToString(),
                            idMotivo = Convert.ToInt32(dr["idMotivo"].ToString()),
                            descMotivo = dr["descMotivo"].ToString(),
                            fecha = dr["fecha"].ToString(),
                        });
                    }
                }
                return oLista;
            }
        }

        public ClienteModel Obtener(int idAtencionCliente)
        {
            var oAtencionCliente = new ClienteModel();
            var cn = new Conexion();
            using (var conexion = new SqlConnection(cn.getCadenaSQL()))
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("sp_cliente_get", conexion);
                cmd.Parameters.AddWithValue("IdAtencionCliente", idAtencionCliente);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        oAtencionCliente.idAtencionCliente = Convert.ToInt32(dr["idAtencionCliente"]);
                        oAtencionCliente.nombres = dr["nombres"].ToString();
                        oAtencionCliente.apellidos = dr["apellidos"].ToString();
                        oAtencionCliente.celular = dr["celular"].ToString();
                        oAtencionCliente.email = dr["email"].ToString();
                        oAtencionCliente.sexo = Convert.ToInt32(dr["sexo"].ToString());
                        oAtencionCliente.idMotivo = Convert.ToInt32(dr["idMotivo"].ToString());
                        oAtencionCliente.descSexo = dr["descSexo"].ToString();
                        oAtencionCliente.idMotivo = Convert.ToInt32(dr["idMotivo"].ToString());
                        oAtencionCliente.descMotivo = dr["descMotivo"].ToString();
                        oAtencionCliente.fecha = dr["fecha"].ToString();
                    }
                    return oAtencionCliente;
                }
            }
        }

        public int Guardar(ClienteModel oAtencionCLiente)
        {
            int rpta;
            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("sp_cliente_ins", conexion);
                    cmd.Parameters.AddWithValue("nombres", oAtencionCLiente.nombres);
                    cmd.Parameters.AddWithValue("apellidos", oAtencionCLiente.apellidos);
                    cmd.Parameters.AddWithValue("celular", oAtencionCLiente.celular);
                    cmd.Parameters.AddWithValue("email", oAtencionCLiente.email);
                    cmd.Parameters.AddWithValue("sexo", oAtencionCLiente.sexo);
                    cmd.Parameters.AddWithValue("idMotivo", oAtencionCLiente.idMotivo);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    rpta = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = 0;
            }
            return rpta;
        }

        public bool Editar(ClienteModel oAtencionCLiente)
        {
            bool rpta;
            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("sp_cliente_edi", conexion);
                    cmd.Parameters.AddWithValue("IdAtencionCliente", oAtencionCLiente.idAtencionCliente);
                    cmd.Parameters.AddWithValue("nombres", oAtencionCLiente.nombres);
                    cmd.Parameters.AddWithValue("apellidos", oAtencionCLiente.apellidos);
                    cmd.Parameters.AddWithValue("celular", oAtencionCLiente.celular);
                    cmd.Parameters.AddWithValue("email", oAtencionCLiente.email);
                    cmd.Parameters.AddWithValue("sexo", oAtencionCLiente.sexo);
                    cmd.Parameters.AddWithValue("idMotivo", oAtencionCLiente.idMotivo);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }

        public bool Eliminar(int idAtencionCliente)
        {
            bool rpta;
            try
            {
                var cn = new Conexion();
                using (var conexion = new SqlConnection(cn.getCadenaSQL()))
                {
                    conexion.Open();
                    SqlCommand cmd = new SqlCommand("sp_cliente_del", conexion);
                    cmd.Parameters.AddWithValue("IdAtencionCliente", idAtencionCliente);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
                rpta = true;
            }
            catch (Exception e)
            {
                string error = e.Message;
                rpta = false;
            }
            return rpta;
        }
    }
}

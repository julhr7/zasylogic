using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Atencion_Cliente.Datos;
using Atencion_Cliente.Models;
using Atencion_Cliente.ViewModels;

namespace Atencion_Cliente.Controllers
{
    public class ClienteController : Controller
    {
        ClienteDatos _ClienteDatos = new ClienteDatos();
        MotivoDatos _MotivoDatos = new MotivoDatos();

        ClienteView vm = new ClienteView();

        public IActionResult Listar(ClienteView oCliente)
        {
            string vFecha = oCliente.fecha == null? "": (oCliente.fecha.Substring(8, 2) + "/" + oCliente.fecha.Substring(5, 2) + "/" + oCliente.fecha.Substring(0, 4));
            vm.ClienteList = _ClienteDatos.Listar(vFecha);
            return View(vm);
        }

        public IActionResult Nuevo()
        {
            var oLista = _MotivoDatos.Listar();
            var vm = new ClienteModel();
            vm.MotivoList = oLista;
            return View(vm);
        }

        [HttpPost]
        public IActionResult Guardar(ClienteModel oCliente)
        {
            if (!ModelState.IsValid)
            {
                var oLista = _MotivoDatos.Listar();
                var vm = new ClienteModel();
                vm.MotivoList = oLista;
                return View("Nuevo", vm);
            }

            oCliente.respuesta = _ClienteDatos.Guardar(oCliente);
            if (oCliente.respuesta == 1)
                return RedirectToAction("Listar");
            else
            {
                var oLista = _MotivoDatos.Listar();
                oCliente.MotivoList = oLista;
                return View("Nuevo", oCliente);
            }
                
        }


        public IActionResult Editar(int idCliente)
        {
            var oCliente = _ClienteDatos.Obtener(idCliente);
            var oLista = _MotivoDatos.Listar();
            oCliente.MotivoList = oLista;
            return View(oCliente);
        }

        [HttpPost]
        public IActionResult Editar(ClienteModel oCliente)
        {
            if (!ModelState.IsValid)
                return View();

            var respuesta = _ClienteDatos.Editar(oCliente);
            if (respuesta)
                return RedirectToAction("Listar");
            else
                return View();
        }

        public IActionResult Eliminar(int idCliente)
        {
            var oCliente = _ClienteDatos.Obtener(idCliente);
            var oLista = _MotivoDatos.Listar();
            return View(oCliente);
        }

        [HttpPost]
        public IActionResult Eliminar(ClienteModel oCliente)
        {
            var respuesta = _ClienteDatos.Eliminar(oCliente.idAtencionCliente);
            if (respuesta)
                return RedirectToAction("Listar");
            else
                return View();
        }
    }
}
